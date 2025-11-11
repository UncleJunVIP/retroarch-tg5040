ARG BASE_IMAGE=retroarch-base:latest

FROM ${BASE_IMAGE}

USER builder
WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/libretro/libretro-uae.git puae2021 && \
    cd puae2021 && \
    make -j$(nproc) && \
    mkdir -p /home/builder/out && \
    find . -name "*puae*libretro.so" -o -name "*uae*libretro.so" | head -1 | xargs -I {} cp {} /home/builder/out/puae2021_libretro.so

RUN mkdir -p /home/builder/out/info && \
    wget -q -O /home/builder/out/info/puae2021_libretro.info \
    "https://raw.githubusercontent.com/libretro/libretro-super/master/dist/info/puae2021_libretro.info" || \
    echo "Warning: Could not download info file"

WORKDIR /home/builder

ENTRYPOINT ["bash"]