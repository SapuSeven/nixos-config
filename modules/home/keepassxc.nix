{
  config,
  pkgs,
  ...
}: let
  keepassxc = pkgs.keepassxc.override {
    withKeePassYubiKey = false;
  };
  db = "default";
  location = "${config.home.homeDirectory}/Files/KeePass";
  secretName = "keepass-${db}";
  passwordFile = config.age.secrets.${secretName}.path;
in {
  age.secrets.${secretName}.file = ../../secrets + "/${secretName}.age";

  home = {
    packages = [
      (pkgs.symlinkJoin {
        name = "keepassxc";
        paths = [keepassxc];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/keepassxc \
            --run "mkdir -p .mozilla/native-messaging-hosts && touch ~/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json" \
            --add-flags "${location}/${db}.kdbx --keyfile ${location}/${db}.key --pw-stdin" \
            --run 'exec 0< "${passwordFile}"'
        '';
      })
    ];

    persistence."/nix/persist".files = [".cache/keepassxc/keepassxc.ini"];

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
