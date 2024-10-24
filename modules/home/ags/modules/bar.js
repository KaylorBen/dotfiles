const hyprland = await Service.import("hyprland")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e"']
})

  const icons = [
    // secondary monitor
    "SGE", // 1
    "AST", // 2
    "SCH", // 3
    "WHM", // 4
    "WAR", // 5
    "PLD", // 6
    "DRK", // 7
    "GNB", // 8
    "MNK", // 9
    "RDM", // 10

    // primary monitor
    "PCT", // 11
    "BLM", // 12
    "NIN", // 13
    "SAM", // 14
    "VPR", // 15
    "SMN", // 16
    "DRG", // 17
    "MCH", // 18
    "DNC", // 19
    "BRD", // 20
  ];

function Workspaces(monitor = 0) {
  const activeId = hyprland.active.workspace.bind("id")
  const workspaces = hyprland.bind("workspaces")
    .as(ws => ws.filter(({ id }) => (monitor * 10 < id && id <= monitor * 10 + 10)).map(({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Icon({
        icon: icons[id-1],
        size: (monitor == 0) ? 20 : 35,
      }),
      class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
    })))

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  })
}

function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    label: hyprland.active.client.bind("title"),
  })
}

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  })
}

function Media() {
  const label = Utils.watch("", mpris, "player-changed", () => {
    if (mpris.players[0]) {
      const { track_artists, track_title } = mpris.players[0]
      return `🎵 ${track_artists.join(", ")} - ${track_title}`
    } else {
      return "Nothing is playing"
    }
  })

  return Widget.Button({
    class_name: "media",
    on_primary_click: () => mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => mpris.getPlayer("")?.next(),
    on_scroll_down: () => mpris.getPlayer("")?.previous(),
    child: Widget.Label({ label }),
  })
}

function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  }

  function getIcon() {
    const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
      threshold => threshold <= audio.speaker.volume * 100)

    return `audio-volume-${icons[icon]}-symbolic`
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  })

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => audio.speaker.volume = value,
    setup: self => self.hook(audio.speaker, () => {
      self.value = audio.speaker.volume || 0
    }),
  })

  return Widget.Box({
    class_name: "volume",
    css: "min-width: 180px",
    children: [icon, slider],
  })
}

function SysTray() {
  const items = systemtray.bind("items")
    .as(items => items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind("icon") }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind("tooltip_markup"),
    })))

  return Widget.Box({
    children: items,
  })
}

function Left(monitor = 0) {
  return Widget.Box({
    hpack: "start",
    spacing: 8,
    class_name: "block",
    children: [
      Workspaces(monitor),
      ClientTitle(),
    ],
  })
}

function Center(monitor = 0) {
  return (monitor != 0) ? Widget.Box({
    hpack: "center",
    spacing: 8,
    class_name: "block",
    children: [
      Media(),
    ],
  }) : Widget.Box();
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    marginRight: 8,
    class_name: "block",
    children: [
      Volume(),
      SysTray(),
      Clock(),
    ],
  })
}

export function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`,
    css: (monitor == 1) ? "-gtk-dpi: 130;" : "-gtk-dpi: 70",
    class_name: "bar",
    margins: [4, 2, 0],
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(monitor),
      center_widget: Center(monitor),
      end_widget: Right(),
    }),
  })
}
