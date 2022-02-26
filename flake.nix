{
  description = "The BYOND game engine.";

  inputs.byond = {
    type = "tarball";
    #Unfortunately, there does not appear to be any way to either generate this URL from the version numbers or get the version numbers from the URL.
    url = "https://www.byond.com/download/build/514/514.1581_byond.zip";
    flake = false;
  };

  inputs.dx2010 = {
    url = "path:./dx2010";
    flake = false;
  };

  outputs = { self, nixpkgs, byond, dx2010, ... }: let byond_ver = "514"; byond_build = "1581"; in rec {
    packages.x86_64-linux.byond = with import nixpkgs { config.allowUnfree = true; system = "x86_64-linux"; };
      stdenv.mkDerivation (let wineprefix = "~/.wineprefix/byond"; in {
        pname = "byond";
        version = "${byond_ver}.${byond_build}";
        src = "${byond}";

        buildInputs = [ pkgs.wine pkgs.winetricks ];

        installPhase = ''
          mkdir -p $out
          cp -a * $out

          cd $out/bin
          echo "#! /usr/bin/bash" >> runbyond
          echo "WINEPREFIX=${wineprefix}" >> runbyond #You're not supposed to use tilde expansion directly in an export statement, and $HOME doesn't work here without double-escaping it
          echo "export WINEPREFIX" >> runbyond
          echo "export WINE=${wine}/bin/wine" >> runbyond
          echo "export WINEPATH=$out/bin" >> runbyond
          echo "export WINEARCH=win32" >> runbyond

          echo "if [ ! -d ${wineprefix} ]; then" >> runbyond

          echo "\$WINE ${dx2010}/DXSETUP.exe" >> runbyond

          echo "${winetricks}/bin/winetricks allfonts mfc42 gdiplus vcrun2010 wsh57 windowscodecs ogg ole32 riched30 msls31 wmp10 vlc" >> runbyond
          echo "${winetricks}/bin/winetricks ie8" >> runbyond

          echo "fi" >> runbyond

          cat runbyond >> byond
          echo "\$WINE $out/bin/byond.exe" >> byond

          chmod +x byond

          # cat runbyond >> dreamseeker
          # echo "\$WINE $out/bin/dreamseeker.exe" >> dreamseeker

          # chmod +x dreamseeker

          # cat runbyond >> dreammaker
          # echo "\$WINE $out/bin/dreammaker.exe" >> dreammaker

          # chmod +x dreammaker

          # cat runbyond >> DreamMaker
          # echo "\$WINE $out/bin/dm.exe \$1" >> DreamMaker

          # chmod +x DreamMaker
        '';

        meta = with lib; { #Is this even useful in a flake?
          description = "The BYOND game engine, plus dependencies for at least SS13.";
          homepage = "https://www.byond.com/";
          license = licenses.unfree;
          platforms = [ "x86_64-linux" ];
        };
      });

    defaultPackage.x86_64-linux = packages.x86_64-linux.byond;
  };
}
