# Vers l'infini et hoplà !

Projet Museomix Alsace 2025

## Usage

This project contains a SD image for a Raspberry PI 4.
The Raspberry will play a single file on its headphone output, looping and at full volume.

### Building

1. Have nix installed, and be able to build aarch64 packages (either native or emulation).
2. Clone this repository
3. Run `nix build`
4. The SD image is under `result/sd-image`
5. Use `dd`, or your favorite tool to flash the SD card
6. Power the Pi, and plug speakers or headphones in the output.
7. Enjoy!

## License

Portions of this software are derived from [nixpkgs](https://github.con/nixos/nixpkgs), 
Copyright (c) 2003-2025 Eelco Dolstra and the Nixpkgs/NixOS contributors, licensed under the MIT License.
See the file LICENSE.MIT for details.

All other portions are licensed under the GNU Lesser General Public License, version 2.
See the file LICENSE.LGPL for details.

The sound files are licensed under the Creative Commons Attribution Share Alike 4.0 International.
See the file LICENSE.CC-BY-SA for details.

