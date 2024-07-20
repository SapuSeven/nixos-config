{ pkgs, ... }:
{
  home = {
    packages = with pkgs.stable; [
      (symlinkJoin {
        name = "TeamSpeak";
        paths = [ teamspeak5_client ];
        buildInputs = [ makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/TeamSpeak \
            --append-flags "--ozone-platform=wayland"
        '';
      })
    ];
  };
}
