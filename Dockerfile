FROM crosstool-ng-builder:latest AS toolchain-base

USER root

RUN apt-get update && apt-get install -y \
    pkg-config libasound2-dev \
    libsdl2-dev libxkbcommon-dev \
    cmake \
    autoconf automake libtool \
    python3 \
    && rm -rf /var/lib/apt/lists/*

USER builder
WORKDIR /home/builder

RUN git clone https://github.com/libretro/libretro-super.git
WORKDIR /home/builder/libretro-super

RUN NOCLEAN=1  ./libretro-fetch.sh

# Build RetroArch Cores
RUN ./libretro-build.sh

WORKDIR /home/builder/libretro-super/retroarch
RUN  ./configure \
        --enable-sdl2 \
        --enable-alsa \
        --disable-pulse \
        --disable-opengl \
        --disable-opengles \
        --disable-kms \
        --disable-x11 \
        --disable-wayland \
        --disable-vulkan \
        --disable-xvideo \
        --disable-xinerama \
        --disable-xshm \
        --disable-xrandr \
        --disable-ffmpeg

RUN make clean
RUN make -j$(nproc)

# DEBUG: Show what was actually built
RUN echo "=== DEBUG INFO ===" && \
    find /home/builder -name "retroarch" -type f 2>/dev/null && \
    echo "=== Contents of libretro-super ===" && \
    ls -la /home/builder/libretro-super/ && \
    echo "=== Contents of retroarch dir ===" && \
    ls -la /home/builder/libretro-super/retroarch/ && \
    echo "=== Contents of dist ===" && \
    ls -la /home/builder/libretro-super/dist/ || echo "dist dir doesn't exist"

# Create output directories
RUN mkdir -p /home/builder/out \
    && mkdir -p /home/builder/out/cores \
    && mkdir -p /home/builder/out/cores/info \
    && mkdir -p /home/builder/out/lib

# Copy RetroArch executable
RUN cp /home/builder/libretro-super/retroarch/retroarch /home/builder/out/

# Copy all cores
RUN cp /home/builder/libretro-super/dist/unix/*.so /home/builder/out/cores/ || true

# Copy core info files
RUN cp /home/builder/libretro-super/dist/info/*.info /home/builder/out/cores/info/ || true

# Copy required libraries
RUN cp /usr/lib/*/libxkbcommon.so.0 /home/builder/out/lib/ || true

WORKDIR /home/builder

ENTRYPOINT ["bash"]
