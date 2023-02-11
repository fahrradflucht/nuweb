FROM rust as builder

RUN apt install pkg-config libssl-dev

RUN cargo install nu

FROM httpd

RUN apt update && \
    apt upgrade -y && \
    apt install -y pandoc && \
    apt clean

COPY --from=builder /usr/local/cargo/bin/nu /usr/local/bin/nu

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY cgi-bin /usr/local/apache2/cgi-bin
