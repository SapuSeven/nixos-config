{pkgs, ...}: {
  services.udev = {
    packages = with pkgs.stable; [
      platformio-core.udev
      qmk-udev-rules
    ];
  };
}
