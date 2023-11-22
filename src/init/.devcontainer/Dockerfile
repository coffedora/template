# templateOption default overrides Dockerfile default and build args. 
FROM quay.io/fedora/fedora-minimal:${templateOption:imageVariant}
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY ./bin/ /usr/local/bin/
ARG USERNAME=fedora
ARG USERSHELL=bash
ARG USER_UID=1000
ARG INSTALL_HOMEBREW=false
RUN chmod +rx /usr/local/bin/* || true \
    && dnf -y update \
    && dnf -y install ${USERSHELL} git gh gcc gcc-c++ passwd sudo tar unzip util-linux wget which xz zip \
    less ncurses openssh-clients procps procps-ng psmisc rsync shadow-utils strace \
    && groupadd --gid ${USER_UID} ${USERNAME} \
    && useradd --uid ${USER_UID} -s /bin/${USERSHELL} --gid ${USER_GID} -m ${USERNAME} \
    && mkdir -p /workspaces && chown -R ${USERNAME} /workspaces \
    && ln -s /workspaces/ /home/${USERNAME}/workspaces \
    && usermod -aG wheel ${USERNAME} \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && chown ${USERNAME} /usr/local/bin/ \
    && chown -R /home/${USERNAME} \
    && dnf clean all \
    && rm -rfd /var/cache/dnf /tmp/* /var/tmp/* /.dockerenv\ 
    && passwd -d ${USERNAME}\
USER ${USERNAME}
ENV PATH "$HOME/bin:$HOME/.local/bin:${PATH}"
VOLUME [ "/home/linuxbrew/" ]
RUN if  [[ $INSTALL_HOMEBREW == "true" ]]; then \
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";fi \
&& eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
WORKDIR /home/${USERNAME}/workspaces
LABEL version="0.1.0"
LABEL org.opencontainers.image.authors="disev@d1sev.dev"
LABEL org.opencontainers.image.description="This Containerfile creates a fedora-minimal image \
    to meet the minimal requirements of the devcontainer cli and skip most repeated installation \
    for a full user enviroment."
LABEL changes="installs gh git which wget tar xz zip tar sudo to run \
    common shell commands. Links dnf5 to dnf for backward compatibility. \
    Adds user home for UID=1000"