FROM golang:1.13-alpine AS build

ENV GO111MODULE on
ENV CGO_ENABLED 0
ENV GOOS linux

RUN apk add git make openssl

WORKDIR /go/src/github.com/alex-leonhardt/k8s-mutate-webhook
ADD . .
RUN make app

FROM alpine

RUN apk --no-cache add ca-certificates && mkdir -p /app
WORKDIR /app
COPY --from=build /go/src/github.com/alex-leonhardt/k8s-mutate-webhook/mutateme .
COPY --from=build /go/src/github.com/alex-leonhardt/k8s-mutate-webhook/ssl ssl
CMD ["/app/mutateme"]
