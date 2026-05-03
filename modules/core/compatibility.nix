{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Gaming specific libraries
      (runCommand "steamrun-lib" {} "mkdir $out; ln -s ${steam-run.fhsenv}/usr/lib64 $out/lib")
      libGLU

      # Misc
      pulseaudio
      libx11
      libxext
      libxinerama
      libxcursor
      libxrandr
      vulkan-loader
    ];
  };
}
