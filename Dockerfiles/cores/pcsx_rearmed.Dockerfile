FROM retroarch-base:latest

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/pcsx_rearmed.git pcsx_rearmed && \
    cd pcsx_rearmed && \
    make -f Makefile.libretro -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp pcsx_rearmed_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/pcsx_rearmed_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/pcsx_rearmed_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]
