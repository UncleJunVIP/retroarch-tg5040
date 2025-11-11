ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/PokeMini.git pokemini && \
    cd pokemini && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp pokemini_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/pokemini_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/pokemini_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]