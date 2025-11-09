ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/nestopia.git nestopia && \
    cd nestopia/libretro && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp nestopia_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/nestopia_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/nestopia_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]
