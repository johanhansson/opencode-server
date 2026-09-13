FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        unzip \
        git && \
    rm -rf /var/lib/apt/lists/*

ENV OPENCODE_INSTALL_DIR=/usr/local/bin
RUN curl -fsSL https://opencode.ai/install | bash && \
    OPENCODE_BIN="$(find / \( -path /proc -o -path /sys \) -prune -o -type f -iname opencode -print 2>/dev/null | head -n1)" && \
    if [ -z "$OPENCODE_BIN" ]; then echo "ERROR: opencode binary not found after install" >&2; exit 1; fi && \
    echo "opencode installed at: $OPENCODE_BIN" && \
    if [ "$OPENCODE_BIN" != "/usr/local/bin/opencode" ]; then ln -sf "$OPENCODE_BIN" /usr/local/bin/opencode; fi && \
    opencode --version

WORKDIR /workspace

EXPOSE 4096

ENTRYPOINT ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "4096"]
