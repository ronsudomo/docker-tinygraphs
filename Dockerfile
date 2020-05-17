FROM golang:latest as builder

RUN go get -tags netgo -installsuffix netgo github.com/taironas/tinygraphs/...


FROM alpine:3.8

RUN apk --no-cache add ca-certificates

COPY --from=builder /go/bin /go/bin
COPY --from=builder /go/pkg /go/pkg

ENV PORT 8080
EXPOSE ${PORT}

CMD /go/bin/tinygraphs