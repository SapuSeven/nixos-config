{pkgs, ...}: {
  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.nix-ld.enable = true;

  # CUPS settings
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      hplip
      brlaser
      (callPackage ./drivers.nix {})
      (callPackage ./filters.nix {})
    ];
  };

  # Add printers
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Label-50x30mm";
        description = "PM-241-BT, 50x30mm labels";
        deviceUri = "usb:///PM-241-BT?serial=Q332G44P0830030";
        model = "Phomemo/PM-241-BT.ppd";
        ppdOptions = {
          PageSize = "w142h85";
          GapHeight = "2";
          Darkness = "3";
        };
      }
      {
        name = "Label-4x6";
        description = "PM-241-BT, 4x6in shipping labels";
        deviceUri = "usb:///PM-241-BT?serial=Q332G44P0830030";
        model = "Phomemo/PM-241-BT.ppd";
        ppdOptions = {
          PageSize = "w288h432";
          Darkness = "3";
        };
      }
    ];
  };
}
