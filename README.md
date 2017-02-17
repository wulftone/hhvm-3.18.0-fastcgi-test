# Example of fastcgi failure on HHVM 3.18.0

Build the image:

    ./build_image.sh

Run the container

    docker-compose up

cURL the webserver

    curl -I localhost:9000

See the error

    HTTP/1.1 502 Bad Gateway
    Server: nginx/1.4.6 (Ubuntu)
    Date: Fri, 17 Feb 2017 03:10:49 GMT
    Content-Type: text/html
    Content-Length: 181
    Connection: keep-alive    curl localhost:9000

    hhvm-3.18.0-fastcgi-test    | 2017/02/16 19:14:18 [error] 10#0: *27 upstream sent unsupported FastCGI protocol version: 72 while reading response header from upstream, client: 172.19.0.1, server: localhost, request: "HEAD / HTTP/1.1", upstream: "fastcgi://127.0.0.1:9002", host: "localhost:9000"
    hhvm-3.18.0-fastcgi-test    | 172.19.0.1 - - [16/Feb/2017:19:14:18 -0800] "HEAD / HTTP/1.1" 502 0 "-" "curl/7.43.0"

Try the "fastcgi" port

    $ curl -I localhost:9002
    HTTP/1.1 200 OK
    Vary: Accept-Encoding
    Content-Type: text/html
    X-Powered-By: HHVM/3.18.0
    Date: Fri, 17 Feb 2017 03:16:39 GMT
    Connection: keep-alive
    Content-Length: 6

Edit the `Dockerfile` and use HHVM 3.17.2, repeat the above steps

    $ curl -I localhost:9000
    HTTP/1.1 200 OK
    Server: nginx/1.4.6 (Ubuntu)
    Date: Fri, 17 Feb 2017 03:12:32 GMT
    Content-Type: text/html
    Connection: keep-alive
    X-Powered-By: HHVM/3.17.2
    Vary: Accept-Encoding

    $ curl -I localhost:9002
    ...hangs, as it should, it's fastcgi, not HTTP

Make sure to wait for the server to be fully started or you'll get a 502 anyway.
