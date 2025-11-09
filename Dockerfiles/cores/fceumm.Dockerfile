ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/libretro-fceumm.git fceumm && \
    cd fceumm && \
    make -f Makefile.libretro -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp fceumm_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/fceumm_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/fceumm_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]
