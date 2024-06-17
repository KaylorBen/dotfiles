return {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim", -- for vim
					"awesome",
					"client",
					"screen",
					"root", -- for awesomewm
				},
			},
			runtime = {
				version = "LuaJIT",
				special = {
					spec = "require",
				},
			},
			hint = {
				-- enable = false,
				arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
				await = true,
				paramName = "Disable", -- "All" | "Literal" | "Disable"
				paramType = true,
				semicolon = "All", -- "All" | "SameLine" | "Disable"
				setType = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
