FROM golang:1.19 as builder
#ARG VERSION
#ENV VERSION=$VERSION
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM scratch
WORKDIR /
COPY --from=builder /app/main .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
EXPOSE 8080
ARG VERSION
ENV VERSION=${VERSION}
ENTRYPOINT [ "./main" ]