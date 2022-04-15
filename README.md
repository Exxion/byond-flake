Very early Nix flake to install BYOND and all dependencies required to play SS13. Works, but is very bad.

Don't try to update BYOND with the update button in the pager. I don't know what will happen, but it won't work. Just pester me to update the version on here, or fork it, or override the input with another flake, or something.

**Important note**:

* The first time you run this, I recommend you do it through the console rather than a menu. Running it from a menu will work, but you will have no evidence that anything is happening for several minutes because Winetricks is incredibly slow. If you run it from the console, you can see that stuff is happening. After the first launch, launching from a menu is fine.

Other notes:

* This is my first flake and some of my first work with Linux stuff in general. This will probably be obvious if you look at the code.
* The list of Winetricks is just the one from bwo.ink but with some changes to make it actually work on my machine and actually play jukebox songs. I have no idea how many are actually necessary but I got tired of testing.
* It is, as far as I am aware, impossible to actually have Wine and Winetricks set up their stuff in the build phase of the flake as would make sense. Instead, it happens on first run.
* The first run will take a very long time and will require you to interact with some menus because old Windows installers were bad. It will also place a nonfunctional shortcut to VLC on your desktop. Sorry.
* Only installs the Windows build. See https://github.com/Exxion/byond-linux-flake for the Linux build/server tools.
* The pager and Dream Seeker work fine, but don't try to use Dream Maker. Though I'm not sure why you would want to anyway.
* Creates and uses its own Wine prefix folder at ~/.wineprefix/byond. This can be changed if a different path would be more convenient.
* You can override the BYOND URL for this in a separate flake to use a different BYOND version, though the package will still use the version used here for the name unless you do additional stuff.
* I feel obligated to mention that the style here is standard for Nix and I use it begrudgingly.
