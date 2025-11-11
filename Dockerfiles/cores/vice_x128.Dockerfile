ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/vice-libretro.git vice && \
    cd vice && \
    make -j$(nproc) CORE=x128 && \
    mkdir -p /home/builder/out && \
    find . -name "vice_x128_libretro.so" -exec cp {} /home/builder/out/ \;

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/vice_x128_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/vice_x128_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]