ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/a5200.git a5200 && \
    cd a5200 && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp a5200_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/a5200_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/a5200_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]