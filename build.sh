#!/bin/bash
set -e

docker build -t gsc .

docker run \
    --gpus all \
    --rm -it \
    -e VCPKG_ROOT=/vcpkg \
    -v`pwd`:/app \
    -v`pwd`/vcpkg:/vcpkg/installed \
    gsc \
    bash -c "cd /app && 
                find / -iname 'vcpkg.cmake' && 
                cmake -B build -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
                                -DCMAKE_TOOLCHAIN_FILE='/vcpkg/scripts/buildsystems/vcpkg.cmake' \
                                -DCMAKE_PREFIX_PATH=/app/libtorch/share/cmake/ \
                                -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && 
                cmake --build build -- -j"

docker run --gpus all --rm -it -v`pwd`:/app gsc \
    bash -c "cd /app && scripts/timing_mipnerf360.sh"

