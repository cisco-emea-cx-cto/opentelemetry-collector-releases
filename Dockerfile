FROM alpine:3.16 as certs
RUN apk --update add ca-certificates

FROM scratch

ARG USER_UID=10001
USER ${USER_UID}

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --chmod=755 otelcol-contrib /otelcol-contrib
COPY configs/otelcol-contrib.yaml /etc/otelcol-contrib/config.yaml
ENTRYPOINT ["/otelcol-contrib"]
CMD ["--config", "/etc/otelcol-contrib/config.yaml"]
EXPOSE 4317:4317 55678:55678 55679:55679 161:161/udp 514:514/udp 8889:8889 8888:8888 29018:29018/udp 8000:8000 4433:443 20000:20000
