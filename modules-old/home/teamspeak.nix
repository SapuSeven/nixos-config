{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (symlinkJoin {
        name = "TeamSpeak";
        paths = [teamspeak6-client];
        buildInputs = [makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/TeamSpeak \
            --append-flags "--ozone-platform=wayland"
        '';
      })
    ];
  };
}
