FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	apt-get -y update \
	&& apt-get -y --no-install-recommends install \
			curl \
			ca-certificates \
			unzip \
			gettext-base \
			jq \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /var/log/dpkg.log \
	&& cd /tmp \
	&& ln -sfn /bin/bash /bin/sh \
	&& curl -#L https://releases.hashicorp.com/nomad/1.6.3/nomad_1.6.3_linux_amd64.zip -o nomad.zip \
	&& test "$(sha256sum nomad.zip | cut -f1 -d\ )" = '1771f83030d9c0e25b4b97b73e824f4b566721e3b9898ae9940eceb95bb7f4d0' \
	&& unzip nomad.zip \
	&& mv nomad /usr/local/bin/nomad \
	&& chmod 0755 /usr/local/bin/nomad \
	&& rm nomad.zip

WORKDIR /
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
