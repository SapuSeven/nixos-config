{pkgs, ...}: {
  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  services.udev.extraRules = ''
    # Set volume for Audeze Maxwell Dongle on connect
    ACTION=="add", SUBSYSTEM=="sound", ATTRS{idVendor}=="3329", ATTRS{idProduct}=="4b19", RUN+="${pkgs.alsa-utils}/bin/amixer -D hw:Dongle set 'PCM,0' 100", RUN+="${pkgs.alsa-utils}/bin/amixer -D hw:Dongle set 'PCM,1' 100"
  '';

  # Silent Sound service to workaround the Maxwell initial audio cut-off
  # See https://www.reddit.com/r/Audeze/comments/1f9eolc/maxwell_initial_audio_cutoff_workaround_for_linux/
  systemd.user.services.silent-sound = {
    description = "Silent Sound Service";
    wantedBy = ["default.target"];
    after = ["sound.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ffmpeg}/bin/ffplay -f lavfi -i anullsrc=channel_layout=2:sample_rate=48000 -nodisp -loglevel quiet";
      Restart = "always";
    };
  };
}
