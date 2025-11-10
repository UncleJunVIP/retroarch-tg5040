# RetroArch TG5040

A clean, reproducible build of RetroArch for the TrimUI Brick and Smart Pro.

## Requirements

- Docker installed and running
- Task (taskfile) - install via `brew install go-task` on macOS or `https://taskfile.dev/installation/` for other
  systems
- adb (Android Debug Bridge) if you want to deploy directly to a device
- Linux/macOS environment (or WSL2 on Windows)

## Available Tasks

### Cleaning

- `task clean` - Remove all build artifacts and Docker images. Use this if something goes wrong and you want to start
  fresh.

### Building

- `task build-base` - Creates the base Docker image with SDL2 and other required libraries. This only needs to be run
  once, but run it again if you update `base.Dockerfile`.

- `task build-retroarch` - Compiles the RetroArch frontend. Depends on build-base.

- `task build-core CORE=corename` - Build a single emulator core. Replace `corename` with one of the core names listed
  below.

- `task build-all-cores` - Builds all cores sequentially, one after another. Slower but uses less system resources.

- `task build-cores-parallel` - Builds all cores in parallel using up to four simultaneous builds. Much faster if your
  system can handle it.

### Packaging and Deployment

- `task package` - Takes the built RetroArch and cores, organizes them into the correct directory structure, and creates
  a .pak file suitable for NextUI and similar frontends.

- `task adb` - Pushes the packaged .pak file to your connected TG5040 device via adb. Make sure your device is connected
  and adb is working first.

## Supported Emulators

The system currently builds support for the following platforms. Each is a separate libretro core:

### Nintendo

- **NES** (fceumm, nestopia)
- **SNES** (snes9x)
- **Game Boy / Game Boy Color** (gambatte)
- **Game Boy Advance** (mgba, gpsp)

### Sega

- **Genesis / Mega Drive / Game Gear** (genesis_plus_gx)

### Atari

- **Atari 2600** (stella)
- **Atari 5200** (atari800)
- **Atari 7800** (prosystem)

### Sony

- **PlayStation 1** (pcsx_rearmed)

### Arcade

- **FB Neo** (fbneo)

### Other

- **DOSBox** (dosbox)

## Core Build Variables

The cores to build are defined in the `CORES` variable at the top of taskfile.yml:

`CORES: snes9x,genesis_plus_gx,gambatte,fceumm,nestopia,pcsx_rearmed,mgba,gpsp,stella,atari800,prosystem,dosbox,fbneo`

## Notes

- Each core is built in its own Docker container
- The `.pak` format is specific to NextUI and compatible frontends (Should work with MinUI and PakUI but I haven't personally tested it)
- Builds are isolated and won't affect your system or other projects
- You can safely run `task clean` - it won't delete your source code