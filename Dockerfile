FROM registry.access.redhat.com/ubi9/go-toolset AS builder

COPY app /app

USER root

RUN chmod a+w /app

WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build main.go

FROM scratch

WORKDIR /

COPY --from=builder /app/main .

EXPOSE 9090

ENTRYPOINT ["/main"]
