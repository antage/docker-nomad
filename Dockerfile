FROM debian:stable
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	apt-get -y update \
	&& apt-get -y --no-install-recommends install \
			curl \
			ca-certificates \
			unzip \
			gettext-base \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /var/log/dpkg.log \
	&& cd /tmp \
	&& ln -sfn /bin/bash /bin/sh \
	&& curl -#L https://releases.hashicorp.com/nomad/0.10.4/nomad_0.10.4_linux_amd64.zip -o nomad.zip \
	&& test "$(sha256sum nomad.zip | cut -f1 -d\ )" = '7b12ff24c9ff592978d4c5b5ea06f60bb0aa679055a356b7898e480f0ba63d63' \
	&& unzip nomad.zip \
	&& mv nomad /usr/local/bin/nomad \
	&& chmod 00755 /usr/local/bin/nomad \
	&& rm nomad.zip

USER nobody:nogroup
WORKDIR /
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
