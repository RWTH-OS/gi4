#Download base image ubuntu 16.04
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && \
    apt-get -qq install \
        man-db wget vim nano flex byacc git \
        binutils autoconf automake make cmake \
        qemu-system-x86 nasm gcc \
        g++-multilib gdb ddd qt5-default

# Install Rust toolchain
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly

ENV EDITOR=vim
ENV PATH="/root/.cargo/bin:${PATH}"

CMD echo "This is a teaching box for GI4."; /bin/bash
