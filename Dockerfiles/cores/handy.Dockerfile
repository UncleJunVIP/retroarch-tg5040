ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/libretro-handy.git handy && \
    cd handy && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp handy_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/handy_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/handy_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]