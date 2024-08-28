let
  pkgs = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/a6292e34000dc93d43bccf78338770c1c5ec8a99.tar.gz")
    { };

in pkgs.stdenv.mkDerivation {
  name = "Gravwell Training";
  src = ./.;

  buildInputs = [ pkgs.texlive.combined.scheme-full ];

  buildPhase = ''
    make master.pdf
  '';

  installPhase = ''
    mkdir $out
    cp master.pdf $out
  '';
}
