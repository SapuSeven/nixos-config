{ stdenv, lib, autoPatchelfHook, cups
}:
stdenv.mkDerivation rec {
  name = "cups-filters-${version}";
  version = "1.0";

  src = ./filters;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    cups
  ];

  installPhase = ''
    mkdir -p $out/lib/cups/filter/
    cp ./rastertolabeltspl $out/lib/cups/filter/
  '';
}
