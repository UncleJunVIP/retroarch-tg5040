<div align="center">

<h1>
    RetroArch TG5040
</h1>

<h4>

A clean, reproducible build of RetroArch for the TrimUI Brick and Smart Pro.
</h4>

## [Download this in Pak Store!](https://github.com/UncleJunVIP/nextui-pak-store)

![GitHub License](https://img.shields.io/github/license/UncleJunVip/retroarch-tg5040?style=for-the-badge&color=007C77)
![GitHub Release](https://img.shields.io/github/v/release/UncleJunVIP/retroarch-tg5040?sort=semver&style=for-the-badge&color=007C77)
![GitHub Repo stars](https://img.shields.io/github/stars/UncleJunVip/retroarch-tg5040?style=for-the-badge&color=007C77)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/UncleJunVIP/retroarch-tg5040/total?style=for-the-badge&label=Total%20Downloads&color=007C77)


</div>

## Supported Emulators

The system currently builds support for the following platforms. Each is a separate libretro core:

### Amstrad

- **Amstrad CPC** (cap32)

### Arcade & Other

- **Amiga** (puae2021)
- **Doom** (prboom)
- **FB Neo** (fbneo)
- **MAME** (race)
- **PICO-8** (fake08)

### Atari

- **Atari 2600** (stella2014)
- **Atari 5200** (a5200)
- **Atari 7800** (prosystem)
- **Atari Lynx** (handy)

### Coleco

- **ColecoVision** (gearcoleco)

### Commodore

- **Commodore 128** (vice_x128)
- **Commodore 64** (vice_x64)
- **Commodore PET** (vice_xpet)
- **Commodore Plus/4** (vice_xplus4)
- **Commodore VIC-20** (vice_xvic)

### NEC

- **PC Engine / TurboGrafx-16** (mednafen_pce_fast)
- **Virtual Boy** (mednafen_vb)

### Nintendo

- **Game Boy / Game Boy Color** (gambatte)
- **Game Boy Advance** (gpsp, mgba)
- **NES** (fceumm, nestopia)
- **Pokémon Mini** (pokemini)
- **SNES** (snes9x)
- **Super Famicom** (mednafen_supafaust)

### Other

- **DOSBox** (dosbox)

### Sega

- **Genesis / Mega Drive / Game Gear** (genesis_plus_gx)
- **Master System** (bluemsx)
- **Saturn** (mednafen_saturn)

### Sony

- **PlayStation 1** (pcsx_rearmed)

## Building Requirements

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
