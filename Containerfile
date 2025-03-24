MAINTAINER "Joe Terlecki"
FROM quay.io/fedora-ostree-desktops/sway-atomic:41
RUN wget https://pkgs.tailscale.com/stable/fedora/tailscale.repo -P /etc/yum.repos.d/
RUN curl https://packages.microsoft.com/keys/microsoft.asc > /etc/pki/rpm-gpg/microsoft.asc && \
    rpm --import /etc/pki/rpm-gpg/microsoft.asc && \
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
RUN rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm \
    neovim \
    tailscale \
    code && \
    rpm-ostree cleanup -m && \
    ostree container commit
