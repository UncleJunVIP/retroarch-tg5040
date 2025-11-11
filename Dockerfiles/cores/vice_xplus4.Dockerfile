ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/vice-libretro.git vice && \
    cd vice && \
    make -j$(nproc) CORE=xplus4 && \
    mkdir -p /home/builder/out && \
    find . -name "vice_xplus4_libretro.so" -exec cp {} /home/builder/out/ \;

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/vice_xplus4_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/vice_xplus4_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]