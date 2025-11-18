ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/beetle-supergrafx-libretro mednafen_supergrafx && \
    cd mednafen_supergrafx && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp mednafen_supergrafx_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/beetle_supergrafx.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/mednafen_supergrafx_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]