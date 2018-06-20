FROM golang:1.10.3-alpine
ARG NOMAD_VERSION=0.8.4
COPY context /context
RUN apk add --no-cache tar make git gcc musl-dev zip tree bash
WORKDIR $GOPATH/src/github.com/hashicorp/
RUN git clone https://github.com/hashicorp/nomad.git
WORKDIR nomad
RUN git fetch
RUN git checkout v${NOMAD_VERSION} &&\
  make bootstrap &&\
  make pkg/linux_amd64/nomad &&\
  cp pkg/linux_amd64/nomad /context/
WORKDIR /context
USER nobody
CMD ["tar", "cz", "."]
