#Download base image ubuntu 16.04
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Update Software repository
RUN apt-get -qq update

# add https support
RUN apt-get install -y apt-transport-https

# Update Software repository
RUN apt-get -qq update

# Install required packets from ubuntu repository
RUN apt-get install -y man-db nano curl wget vim nano flex git binutils autoconf automake make cmake qemu-system-x86 nasm gcc g++-multilib gdb ddd

# Install Rust toolchain
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly

ENV EDITOR=vim
ENV PATH="/root/.cargo/bin:${PATH}"

CMD echo "This is a teaching box for GI4."; /bin/bash
