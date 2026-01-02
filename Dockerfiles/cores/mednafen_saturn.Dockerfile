ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/beetle-saturn-libretro mednafen_saturn && \
    cd mednafen_saturn && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp mednafen_saturn_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/mednafen_saturn_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/mednafen_saturn_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]
