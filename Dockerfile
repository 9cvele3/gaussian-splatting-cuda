FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 

RUN apt-get update && \
    apt-get install -y software-properties-common lsb-release apt-transport-https ca-certificates gnupg && \
    apt-key adv --fetch-keys https://apt.kitware.com/keys/kitware-archive-latest.asc && \
    apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y \
                cmake \
                curl \
                git \
                libgl1-mesa-dev \
                libglu1-mesa-dev \
                libtbb-dev \
                libwayland-dev \
                libx11-dev \
                libxcursor-dev \
                libxext-dev \
                libxi-dev \
                libxinerama-dev \
                libxkbcommon-dev \
                libxrandr-dev \
                pkg-config \
                python3-dev \
                wayland-protocols \
                wayland-scanner++ 

RUN git clone https://github.com/microsoft/vcpkg.git && \
    cd vcpkg && \
    ./bootstrap-vcpkg.sh

RUN apt-get update && \
    apt-get install -y zip 
