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

Edit the `Dockerfile` and use HHVM 3.17.2, repeat the above steps

    $ curl -I localhost:9000
    HTTP/1.1 200 OK
    Server: nginx/1.4.6 (Ubuntu)
    Date: Fri, 17 Feb 2017 03:12:32 GMT
    Content-Type: text/html
    Connection: keep-alive
    X-Powered-By: HHVM/3.17.2
    Vary: Accept-Encoding
