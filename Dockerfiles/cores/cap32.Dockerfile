ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/libretro-cap32.git cap32 && \
    cd cap32 && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp cap32_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/cap32_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/cap32_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]