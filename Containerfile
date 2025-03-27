FROM quay.io/fedora-ostree-desktops/sway-atomic:41

COPY ./yum.repos.d/*.repo /etc/yum.repos.d/

RUN rpm-ostree override remove firefox firefox-langpacks

RUN sed -i 's|^SHELL=.*|SHELL=/bin/zsh|' /etc/default/useradd

RUN rpm-ostree install \
    tailscale zsh neovim && \
    rpm-ostree cleanup -m && \
    ostree container commit

RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
