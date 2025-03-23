MAINTAINER "Joe Terlecki"
FROM quay.io/fedora-ostree-desktops/sway-atomic:41

RUN wget https://pkgs.tailscale.com/stable/fedora/tailscale.repo -P /etc/yum.repos.d/

RUN rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm \
    neovim \
    tailscale && \
    rpm-ostree cleanup -m && \
    ostree container commit
