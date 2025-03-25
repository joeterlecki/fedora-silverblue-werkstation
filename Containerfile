MAINTAINER "Joe Terlecki"

FROM quay.io/fedora-ostree-desktops/sway-atomic:41
ARG NEOVIM="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz"
ARG TAILSCALE="https://pkgs.tailscale.com/stable/tailscale_1.80.3_amd64.tgz"

RUN rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm && \
    rpm-ostree cleanup -m && \
    ostree container commit
