FROM retroarch-base:latest

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/gambatte-libretro.git gambatte && \
    cd gambatte && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    cp gambatte_libretro.so /home/builder/out/

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/gambatte_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/gambatte_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]
