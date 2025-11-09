FROM retroarch-base:latest

USER builder
WORKDIR /home/builder

RUN git clone https://github.com/libretro/RetroArch.git
WORKDIR /home/builder/RetroArch

RUN ./configure \
        --enable-sdl2 \
        --enable-alsa \
        --disable-pulse \
        --disable-opengl \
        --disable-opengles \
        --disable-kms \
        --disable-x11 \
        --disable-wayland \
        --disable-vulkan \
        --disable-xvideo \
        --disable-xinerama \
        --disable-xshm \
        --disable-xrandr \
        --disable-ffmpeg && \
    make -j$(nproc) && \
    echo "=== Build Complete ===" && \
    ls -lh ./retroarch && \
    file ./retroarch

RUN mkdir -p /home/builder/out && \
    cp /home/builder/RetroArch/retroarch /home/builder/out/

WORKDIR /home/builder

ENTRYPOINT ["bash"]