FROM 0bara/python:3.7.5-ubuntu18.04

MAINTAINER t.obara

RUN apt update -y && apt upgrade -y && \
	apt install -y --no-install-recommends \
	build-essential cmake git curl

WORKDIR /opt
COPY requirements.txt /opt
COPY bin /opt/bin
RUN curl -L https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc3/jumanpp-2.0.0-rc3.tar.xz -o /tmp/j.txz \
	&& cd /tmp && tar xJfv j.txz \
	&& cd jumanpp-2.0.0-rc3 \
	&& mkdir build && cd build \
	&& cmake .. -DCMAKE_BUILD_TYPE=Release \
	&& make install \
	&& cd /opt \
	&& git clone https://github.com/0bara/bert.git \
	&& pip install -r requirements.txt \
	&& rm -rf /tmp/* \
	&& apt autoremove -y build-essential cmake git curl \
	&& apt -y clean \
	&& rm -rf /var/cache/* \
	&& rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

