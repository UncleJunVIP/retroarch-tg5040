FROM retroarch-base:latest

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/Genesis-Plus-GX.git genesis_plus_gx && \
    cd genesis_plus_gx && \
    make -f Makefile.libretro -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp genesis_plus_gx_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/genesis_plus_gx_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/genesis_plus_gx_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]
