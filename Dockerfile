FROM debian:stable
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	apt-get -y update \
	&& apt-get -y --no-install-recommends install \
			curl \
			ca-certificates \
			unzip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /var/log/dpkg.log \
	&& cd /tmp \
	&& curl -#L https://releases.hashicorp.com/nomad/0.9.3/nomad_0.9.3_linux_amd64.zip -o nomad.zip \
	&& test "$(sha256sum nomad.zip | cut -f1 -d\ )" = 'cbd008dd2f3c622cb931ce8e7e6465f5b683e66845eb70adb776c970a8029578' \
	&& unzip nomad.zip \
	&& mv nomad /usr/local/bin/nomad \
	&& chmod 00755 /usr/local/bin/nomad \
	&& rm nomad.zip
