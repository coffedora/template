FROM quay.io/fedora/fedora-minimal:39
COPY ./install.sh /tmp/install.sh
RUN  chmod +x /tmp/install.sh
RUN  /tmp/install.sh
RUN  rm -rdf /tmp/*