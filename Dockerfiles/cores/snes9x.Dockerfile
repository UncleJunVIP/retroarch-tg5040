FROM retroarch-base:latest

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/snes9x.git && \
    cd snes9x/libretro && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp snes9x_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/snes9x_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/snes9x_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]