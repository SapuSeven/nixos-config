{...}: {
  home = {
    # To enroll a Yubikey:
    #  pamu2fcfg > ~/.config/Yubico/u2f_keys
    # To enroll additional Yubikeys:
    #  pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
    persistence."/nix/persist/home/paul".directories = [
      ".config/Yubico"
    ];
  };
}
