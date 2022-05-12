# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libz-dev

## Add source code to the build stage.
ADD . /unshield
WORKDIR /unshield/build

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN cmake ..
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /unshield/build/src/unshield /
COPY --from=builder /unshield/build/lib/libunshield.so.0 /
