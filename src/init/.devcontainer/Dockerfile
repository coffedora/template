# templateOption default overrides Dockerfile default and build args. 
FROM quay.io/fedora/fedora-minimal:${templateOption:imageVariant}
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY ./bin/ /usr/local/bin/
COPY ./.env /tmp/env
ARG USER=${templateOption:username}
ARG USERSHELL=${templateOption:shell}
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG INSTALL_HOMEBREW=true
RUN cat /tmp/.env >> /etc/enviroment || true \
    && chmod +rx /usr/local/bin/* || true \
    && ln -s "$(ls /bin/dnf* | head -n 1)" /usr/local/bin/dnf \
    && dnf -y update \
    && dnf -y install ${USERSHELL} dnf git gh gcc gcc-c++ less ncurses openssh-clients passwd \
        procps procps-ng psmisc rsync shadow-utils strace sudo tar unzip util-linux \
        vim-minimal wget which xz zip \
    && groupadd --gid $USER_GID ${USER} \
    && useradd --uid $USER_UID -s /bin/${USERSHELL} --gid $USER_GID -m ${USER} \
    && chown ${USER} /usr/local/bin/dnf \
    && usermod -aG wheel ${USER} \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER} \
    && mkdir -p /workspaces && chown -R ${USER} /workspaces \
    && dnf clean all \
    && rm -rf /var/cache/dnf\ 
    && passwd -d ${USER}
USER ${USER}
ENV PATH "$HOME/bin:$HOME/.local/bin:${PATH}"
# Mount for docker-in-docker 
RUN if  [[ $INSTALL_HOMEBREW == "true" ]]; then \
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";fi \
&& eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
&& ln -s /workspaces/ ~/workspaces
# VOLUME [ "/var/lib/docker/" ]
# VOLUME [ "/home/linuxbrew/" ]
# WORKDIR /workspaces
# CMD  ["/bin/${USERSHELL} -c"]
LABEL version="0.1.0"
LABEL org.opencontainers.image.authors="disev@d1sev.dev"
LABEL org.opencontainers.image.description="This Containerfile creates a fedora-minimal image \
    to meet the minimal requirements of the devcontainer cli and skip most repeated installation \
    for a full user enviroment."
LABEL changes="installs gh git which wget tar xz zip tar sudo to run \
    common shell commands. Links dnf5 to dnf for backward compatibility. \
    Adds user home for UID=1000"