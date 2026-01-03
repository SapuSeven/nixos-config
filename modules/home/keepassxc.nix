{
  config,
  pkgs,
  ...
}: let
  keepassxc = pkgs.keepassxc.override {
    withKeePassYubiKey = false;
  };
in {
  home = {
    packages = [
      (pkgs.symlinkJoin {
        name = "keepassxc";
        paths = [keepassxc];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/keepassxc \
            --run "touch ~/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json" # This enables the connection to the KeePassXC Firefox extension
        '';
      })
    ];

    persistence."/nix/persist/home/paul".files = [".cache/keepassxc/keepassxc.ini"];

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
      LockDatabaseIdle=false
      LockDatabaseScreenLock=false
    '';
  };
}
