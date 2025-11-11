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

- `task clean` - Remove all build artifacts and Docker images.

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

### Commodore

- **Commodore 64** (vice_x64)
- **Commodore 128** (vice_x128)
- **Commodore PET** (vice_xpet)
- **Commodore Plus/4** (vice_xplus4)
- **Commodore VIC-20** (vice_xvic)

### Nintendo

- **NES** (fceumm, nestopia)
- **SNES** (snes9x)
- **Super Famicom** (mednafen_supafaust)
- **Game Boy / Game Boy Color** (gambatte)
- **Game Boy Advance** (mgba, gpsp)
- **Pokémon Mini** (pokemini)

### Sega

- **Genesis / Mega Drive / Game Gear** (genesis_plus_gx)
- **Master System** (bluemsx)

### Atari

- **Atari 2600** (stella2014)
- **Atari 5200** (a5200)
- **Atari 7800** (prosystem)
- **Atari Lynx** (handy)

### Amstrad

- **Amstrad CPC** (cap32)

### Coleco

- **ColecoVision** (gearcoleco)

### Sony

- **PlayStation 1** (pcsx_rearmed)

### NEC

- **PC Engine / TurboGrafx-16** (mednafen_pce_fast)
- **Virtual Boy** (mednafen_vb)

### Arcade & Other

- **FB Neo** (fbneo)
- **MAME** (race)
- **Doom** (prboom)
- **Amiga** (puae2021)
- **PICO-8** (fake08)

### Other

- **DOSBox** (dosbox)

## Core Build Variables

The cores to build are defined in the `CORES` variable at the top of taskfile.yml:

`CORES: a5200,bluemsx,cap32,dosbox,fake08,fbneo,fceumm,gambatte,gearcoleco,genesis_plus_gx,gpsp,handy,mednafen_pce_fast,mednafen_supafaust,mednafen_vb,mgba,nestopia,pcsx_rearmed,pokemini,prboom,prosystem,puae2021,race,snes9x,stella2014,vice_x64,vice_x128,vice_xpet,vice_xplus4,vice_xvic`