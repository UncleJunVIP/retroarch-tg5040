FROM ghcr.io/loveretro/tg5040-toolchain:modernize

USER root

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    pkg-config \
    libasound2-dev \
    libxkbcommon-dev \
    libxkbcommon0 \
    cmake \
    autoconf \
    automake \
    libtool \
    python3 \
    python3-dev \
    libfreetype6-dev \
    libexpat1-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/libsdl-org/SDL/releases/download/release-2.30.9/SDL2-2.30.9.tar.gz && \
    tar -xzf SDL2-2.30.9.tar.gz && \
    cd SDL2-2.30.9 && \
    ./configure --prefix=/usr && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf SDL2-2.30.9 SDL2-2.30.9.tar.gz

RUN useradd -m builder

USER builder
WORKDIR /home/builder

RUN git clone https://github.com/libretro/RetroArch.git
WORKDIR /home/builder/RetroArch

RUN ./configure \
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
        --disable-ffmpeg && \
    make -j$(nproc) && \
    echo "=== Build Complete ===" && \
    ls -lh ./retroarch && \
    file ./retroarch

RUN mkdir -p /home/builder/out && \
    cp /home/builder/RetroArch/retroarch /home/builder/out/

WORKDIR /home/builder

ENTRYPOINT ["bash"]