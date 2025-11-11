ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/drhelius/Gearcoleco.git gearcoleco && \
    cd gearcoleco/platforms/libretro && \
    make platform=linux CFLAGS="-fPIC -O3 -DNDEBUG" CXXFLAGS="-fPIC -O3 -DNDEBUG" -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp gearcoleco_libretro.dll /home/builder/out/gearcoleco_libretro.so

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/gearcoleco_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/gearcoleco_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]