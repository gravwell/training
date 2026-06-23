let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/a0374025a863d007d98e3297f6aa46cc3141c2f0.tar.gz";
    sha256 = "14c0hqipkcm2iqi5ybjpx4xcvwxjp3sx3rfgb69dv83h0gm1crgn";
  };

  pkgs = import nixpkgs { };

in
pkgs.stdenv.mkDerivation {
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
