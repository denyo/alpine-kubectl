FROM alpine:3

# variable "VERSION" must be passed as docker environment variables during the image build
# docker build --no-cache --build-arg VERSION=1.19.2 -t denyo/alpine-kubectl:1.19.2 .

ARG VERSION

ENV BASE_URL="https://dl.k8s.io"
ENV TAR_FILE="v${VERSION}/kubernetes-client-linux-amd64.tar.gz"

RUN apk add --update --no-cache curl ca-certificates bash && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv kubernetes/client/bin/kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    rm -rf kubernetes && \
    apk del curl && \
    rm -f /var/cache/apk/*

WORKDIR /apps

ENTRYPOINT ["kubectl"]
CMD ["--help"]
