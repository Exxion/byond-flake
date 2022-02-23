Very early Nix flake to install BYOND and all dependencies required to play SS13. Works, but is very bad.

Notes:
* This is my first flake and some of my first work with Linux stuff in general. This will probably be obvious if you look at the code.
* The list of Winetricks is just the one from bwo.ink but with some changes to make it actually work on my machine and actually play jukebox songs. I have no idea how many are actually necessary but I got tired of testing.
* It is, as far as I am aware, impossible to actually have Wine and Winetricks set up their stuff in the build phase of the flake as would make sense. Instead, it happens on first run.
* The first run will take a very long time and will require you to interact with some menus because old Windows installers were bad. It will also place a nonfunctional shortcut to VLC on your desktop. Sorry.
* I'd love to pull in the dx2010 files from a remote tarball rather than bundling them directly, but the tarball I found has all the files directly in it and Nix cannot open a tarball containing more than one top-level file/folder. It's from Lutris, for the record.
* Currently only installs the Windows build. At some point I'll either add the Linux tools or make a separate, much simpler flake for that.
* Creates and uses its own Wine prefix folder at ~/.wineprefix/byond. This can be changed if a different path would be more convenient.
* You can override the BYOND URL for this in a separate flake to use a different BYOND version, though the package will still use the version used here for the name unless you do additional stuff.
* I feel obligated to mention that the style here is standard for Nix and I use it begrudgingly.