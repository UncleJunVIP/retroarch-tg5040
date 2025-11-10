ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/stella-libretro.git stella && \
    cd stella && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp stella2014_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/stella_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/stella_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]