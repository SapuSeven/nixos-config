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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled>
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  # Silent Sound service to workaround the Maxwell initial audio cut-off
  # See https://www.reddit.com/r/Audeze/comments/1f9eolc/maxwell_initial_audio_cutoff_workaround_for_linux/
  systemd.user.services.silent-sound = {
    description = "Silent Sound Service";
    wantedBy = [ "default.target" ];
    after = [ "sound.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ffmpeg}/bin/ffplay -f lavfi -i anullsrc=channel_layout=2:sample_rate=48000 -nodisp -loglevel quiet";
      Restart = "always";
    };
  };
}
