#!/bin/bash

docker build -t gsc .

docker run --gpus all --rm -it -v`pwd`:/app gsc \
    bash -c "cd /app && 
                cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/app/libtorch/share/cmake/ -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && 
                cmake --build build -- -j"

docker run --gpus all --rm -it -v`pwd`:/app gsc \
    bash -c "cd /app && scripts/timing_mipnerf360.sh"
