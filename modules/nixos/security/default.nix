{ config, lib, pkgs, ... }:
let cfg = config.Wotan.security;
in {
  options.Wotan.security = {
    enable = lib.mkEnableOption "Enable security defaults" // { default = true; };
    enableTPM = lib.mkEnableOption "Enable TPM" // { default = false; };
    enableSecureBoot = lib.mkEnableOption "Enable Secure Boot" // { default = false; };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      boot = {
        kernel.sysctl = {
          "dev.tty.ldisc_autoload" =
            0; # Restricts loading TTY lin disciplines to CAP_SYS_MODULE
          "fs.protected_fifos" =
            2; # Prevent creating files in potential attacker controled environment
          "fs.protected_hardlinks" =
            1; # Only allows symlinks to be followed when outside of a world readible sticky directory
          "fs.protected_regular" =
            2; # Prevent creating files in potential attacker controled environment
          "fs.protected_symlinks" =
            1; # Only allows symlinks to be followed when outside of a world readible sticky directory
          "fs.suid_dumpable" = 0; # Prevents process to dump their suid
          "kernel.dmesg_restrict" = 1; # Prevents dmsg leaking sensitive info
          "kernel.kexec_load_disabled" =
            1; # Prevents system call from allowing another kernel during runtime
          "kernel.kptr_restrict" =
            2; # can be set to 1 to only hide kernel pointers
          "kernel.perf_event_paranoid" = 3; # Perf events add attack surface
          "kernel.printk" =
            "3 3 3 3"; # Prevents kernel log printing during boot
          "kernel.sysrq" =
            0; # Magic SysRq key not needed - potential security concern.
          "net.core.default_qdisc" = "cake";
          "net.ipv4.conf.all.accept_redirects" =
            0; # Refuse ICMP redirects (MITM Mitigation)
          "net.ipv4.conf.all.accept_source_route" =
            0; # Reject IP Source route packets (router things)
          "net.ipv4.conf.all.rp_filter" =
            1; # Reverse paath filter prevent IP spoofing
          "net.ipv4.conf.all.secure_redirects" =
            0; # Refuse ICMP redirects (MITM Mitigation)
          "net.ipv4.conf.all.send_redirects" =
            0; # Don't send ICMP redirects (router things)
          "net.ipv4.conf.default.accept_redirects" =
            0; # Refuse ICMP redirects (MITM Mitigation)
          "net.ipv4.conf.default.rp_filter" =
            1; # Reverse paath filter prevent IP spoofing
          "net.ipv4.conf.default.secure_redirects" =
            0; # Refuse ICMP redirects (MITM Mitigation)
          "net.ipv4.conf.default.send_redirects" =
            0; # Don't ICMP redirects (router things)
          "net.ipv4.icmp_echo_ignore_all" = 1; # Prevents smurf attacks
          "net.ipv4.icmp_ignore_bogus_error_responses" = 1; # Log cleanup
          "net.ipv4.tcp_congestion_control" = "bbr"; # Bufferbloat :D
          "net.ipv4.tcp_dsack" =
            0; # Disable TCP Sack, exploitable and not needed
          "net.ipv4.tcp_fack" =
            0; # Disable TCP Sack, exploitable and not needed
          "net.ipv4.tcp_fastopen" =
            3; # Enable fast open - reduce network latency
          "net.ipv4.tcp_rfc1337" =
            1; # Partial protection against TIME-WAIT assasination
          "net.ipv4.tcp_sack" =
            0; # Disable TCP Sack, exploitable and not needed
          "net.ipv4.tcp_syncookies" = 1; # Syn flood attack protection
          "net.ipv6.conf.all.accept_ra" = 0; # IPV6 router advertisment disable
          "net.ipv6.conf.all.accept_redirects" =
            0; # Refuse ICMP redirects (MITM Mitigation)
          "net.ipv6.conf.all.accept_source_route" =
            0; # Reject IP source route packets (router things)
          "net.ipv6.conf.default.accept_ra" =
            0; # IPV6 router advertisment disable
          "net.ipv6.conf.default.accept_redirects" =
            0; # Refuse ICMP redirects (MITM Mitigation)
          "vm.mmap_rnd_bits" = 32; # Increase entropy for mmap ASLR
          "vm.mmap_rnd_compat_bits" = 16; # Increase entropy for mmap ASLR
          "vm.swappiness" = lib.mkDefault 1; # VM swap only when necessary
          "vm.unprivileged_userfaultfd" =
            0; # Restrict userdefaultfd to CAP_SYS_PTRACE to prevent use after free flaws
        };
        kernelModules = [ "tcp_bbr" ];
        kernelParams = [
          "init_on_alloc=1" # Enables zeroing of memory
          "init_on_free=1" # Enables zeroing of memory
          "page_alloc.shuffle=1" # Randomizes page allocator freelist (Also improves performance)
          "randomize_kstack_offset=on" # Randomizes kernel stack offset makes CVE-2019-18683 more difficult
          "vsyscall=none" # Obsolete replaced with vDSO
          "debugfs=off" # Exposes lot of sensitive info about kernel when on
          "oops=panic" # Prevents exploits that cause oops
          "quiet" # Prevent info leaks during boot w/ kernel.printk
          "loglevel=0" # Prevent info leaks during boot w/ kernel.printk
          "intel_iommu=on"
          "amd_iommu=force_isolation"
          "iommu=force"
          "iommu.passthrough=0"
          "iommu.strict=1"
        ];
      };
    })
    (lib.mkIf cfg.enableTPM {
      boot.initrd.kernelModules = [ "tpm_tis" ];
      security.tpm2 = {
        enable = true;
        pkcs11.enable = true;
        tctiEnvironment.enable = true;
      };
    })
    (lib.mkIf cfg.enableSecureBoot {
      environment.systemPackages = [ pkgs.sbctl ];
      boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      };
    })
  ];
}
