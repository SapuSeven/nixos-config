{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      keepassxc
    ];

    persistence."/nix/persist/home/paul".files = [ ".cache/keepassxc/keepassxc.ini" ];

    file."${config.xdg.configHome}/keepassxc/keepassxc.ini".text = ''
	[General]
	ConfigVersion=2

	[Browser]
	CustomProxyLocation=
	Enabled=true

	[GUI]
	ApplicationTheme=classic
	MinimizeOnClose=true
	ShowTrayIcon=true
	TrayIconAppearance=monochrome-light

	[PasswordGenerator]
	AdditionalChars=
	ExcludedChars=

	[SSHAgent]
	Enabled=true

	[Security]
	ClearClipboardTimeout=20
        EnableCopyOnDoubleClick=true
	LockDatabaseScreenLock=false
    '';
  };
}
