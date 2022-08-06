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
	&& curl -#L https://releases.hashicorp.com/nomad/1.3.3/nomad_1.3.3_linux_amd64.zip -o nomad.zip \
	&& test "$(sha256sum nomad.zip | cut -f1 -d\ )" = 'd908811cebe2a8373e93c4ad3d09af5c706241878ff3f21ee0f182b4ecb571f2' \
	&& unzip nomad.zip \
	&& mv nomad /usr/local/bin/nomad \
	&& chmod 00755 /usr/local/bin/nomad \
	&& rm nomad.zip \
	&& curl -#L https://releases.hashicorp.com/levant/0.3.1/levant_0.3.1_linux_amd64.zip -o levant.zip \
	&& test "$(sha256sum levant.zip | cut -f1 -d\ )" = '01b4a15a1eb5d6c69178ff383a457a6251658224dd9537fe1ea9f24e07044f76' \
	&& unzip levant.zip \
	&& mv levant /usr/local/bin/levant \
	&& rm levant.zip

USER nobody:nogroup
WORKDIR /
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
