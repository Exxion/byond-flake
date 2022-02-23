{
  description = "The BYOND game engine";

  inputs.nixpkgs = {
    type = "indirect";
    id = "nixpkgs";
  };

  inputs.byond = {
    type = "tarball";
    #version = 514;
    #build = 1580;
    url = "https://www.byond.com/download/build/514/514.1580_byond.zip";
    flake = false;
  };

  inputs.dx2010 = {
    url = "path:./dx2010";
    flake = false;
  };

  outputs = { self, nixpkgs, byond, dx2010, ... }: {
    packages.x86_64-linux."514.1580_byond" = with import nixpkgs { config.allowUnfree = true; system = "x86_64-linux"; };
      stdenv.mkDerivation (let wineprefix = "~/.wineprefix/byond"; in {
        pname = "byond";
        version = "514.1580";
        src = "${byond}";

        buildInputs = [ pkgs.wine pkgs.winetricks ];

        installPhase = ''
          mkdir -p $out
          cp -a * $out

          cd $out/bin
          echo "export WINEPREFIX=${wineprefix}" >> runbyond
          echo "export WINE=${wine}/bin/wine" >> runbyond
          echo "export WINEPATH=$out/bin" >> runbyond
          echo "export WINEARCH=win32" >> runbyond

          echo "if [ ! -d ${wineprefix} ]; then" >> runbyond

          echo "${wine}/bin/wine ${dx2010}/DXSETUP.exe" >> runbyond

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
      });

    defaultPackage.x86_64-linux = self.outputs.packages.x86_64-linux."514.1580_byond";
  };
}
