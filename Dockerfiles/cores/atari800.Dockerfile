ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/libretro-atari800.git atari800 && \
    cd atari800 && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp atari800_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/atari800_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/atari800_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]