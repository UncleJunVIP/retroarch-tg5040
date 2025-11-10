ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/prosystem-libretro.git prosystem && \
    cd prosystem && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp prosystem_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/prosystem_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/prosystem_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]