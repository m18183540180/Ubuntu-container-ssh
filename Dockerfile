FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical
ENV TZ=Asia/Shanghai
ENV S6_OVERLAY_VERSION=3.2.0.0
RUN apt-get update && apt-get install -y curl xz-utils; \
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz" \
        -o /tmp/s6o.tar.xz; \
    tar -Jxf /tmp/s6o.tar.xz -C /; \
    rm -f /tmp/s6o.tar.xz
RUN apt-get update && apt-get install -y \
curl \
sudo \
git \
wget \
build-essential \
python3 \
python3-pip \
nano \
zip \
unzip \
tar \
gzip \
bzip2 \
unminimize \
net-tools \
iproute2 \
ca-certificates \
tzdata \
procps \
lsb-release \
less \
iputils-ping \
traceroute \
dnsutils \
file \
tree \
htop \
vim \
locales \
software-properties-common \
ncdu \
util-linux \
openssh-server \
fdisk \
telnet \
tcpdump \
rsync \
jq \
ripgrep \
watch \
bc \
passwd \
default-jdk \
man-db \
diffutils \
patch \
groff-base \
mtr \
language-pack-zh-hans
RUN locale-gen zh_CN.UTF-8
RUN update-locale LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:@Awf123456789' | chpasswd
RUN mkdir -p /etc/services.d/sshd; \
    printf '#!/bin/sh\nexec /usr/sbin/sshd -D\n' > /etc/services.d/sshd/run; \
    chmod +x /etc/services.d/sshd/run
USER root
ENTRYPOINT ["/init"]