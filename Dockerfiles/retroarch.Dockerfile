FROM retroarch-base:latest

USER builder
WORKDIR /home/builder

RUN git clone https://github.com/libretro/RetroArch.git
WORKDIR /home/builder/RetroArch

RUN ./configure \
        --enable-sdl2 \
        --enable-alsa \
        --enable-opengles \
        --disable-pulse \
        --disable-opengl \
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

RUN mkdir -p /home/builder/out/assets/shaders && \
    git clone --depth 1 https://github.com/libretro/glsl-shaders.git /tmp/glsl-shaders && \
    cp -r /tmp/glsl-shaders/* /home/builder/out/assets/shaders/ && \
    rm -rf /tmp/glsl-shaders && \
    echo "Shaders downloaded successfully"

WORKDIR /home/builder

ENTRYPOINT ["bash"]