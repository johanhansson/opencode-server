FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        unzip \
        git && \
    rm -rf /var/lib/apt/lists/*

ENV OPENCODE_INSTALL_DIR=/usr/local/bin
RUN curl -fsSL https://opencode.ai/install | bash

WORKDIR /workspace

EXPOSE 4096

ENTRYPOINT ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "4096"]
