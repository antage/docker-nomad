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
	&& curl -#L https://releases.hashicorp.com/nomad/1.2.3/nomad_1.2.3_linux_amd64.zip -o nomad.zip \
	&& test "$(sha256sum nomad.zip | cut -f1 -d\ )" = '9e5c6354345c88f0ce3c9ceb6a61471903596febc933245a0fbe1afc89c21d31' \
	&& unzip nomad.zip \
	&& mv nomad /usr/local/bin/nomad \
	&& chmod 00755 /usr/local/bin/nomad \
	&& rm nomad.zip \
	&& curl -#L https://releases.hashicorp.com/levant/0.3.0/levant_0.3.0_linux_amd64.zip -o levant.zip \
	&& test "$(sha256sum levant.zip | cut -f1 -d\ )" = '082bd747cf49bc317035a4caab8742924eac67605a82b1b5f4640d896999ea98' \
	&& unzip levant.zip \
	&& mv levant /usr/local/bin/nomad \
	&& rm levant.zip

USER nobody:nogroup
WORKDIR /
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
