{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation rec {
  name = "cups-drivers-${version}";
  version = "1.0";

  src = ./drivers;

  buildInputs = with pkgs; [
    git
  ];

  installPhase = ''
    mkdir -p $out/share/cups/model/Phomemo
    git apply --whitespace=fix *.patch
    cp ./PM-*.ppd $out/share/cups/model/Phomemo
  '';
}
