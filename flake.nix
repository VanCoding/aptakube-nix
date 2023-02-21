{
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux; stdenv.mkDerivation rec {
      pname = "aptakube";
      version = "1.2.1";
      src = fetchurl {
        url = "https://releases.aptakube.com/aptakube_${version}_amd64.deb";
        hash = "sha256-C++I/7p9A7XrpleqFK8kJDyMJ0fUAKnIK3ihmYWlqfE=";
      };
      unpackPhase = ''
        dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
      '';
      buildInputs = [
        gdk-pixbuf
        glib
        webkitgtk
      ];
      nativeBuildInputs = [
        dpkg
        autoPatchelfHook
      ];
      installPhase = ''
        mkdir -p $out/bin
        cp -R usr/** $out/
      '';
    };
  };
}
