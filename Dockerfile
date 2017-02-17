# FROM hhvm/hhvm-proxygen:3.17.2
FROM hhvm/hhvm-proxygen:3.18.0

RUN apt-get update && apt-get install -y curl nginx

EXPOSE 9000

RUN useradd -ms /bin/bash app
RUN install -d -m 755 -o app /app

RUN /usr/share/hhvm/install_fastcgi.sh
COPY config/default.conf /etc/nginx/sites-available/default
COPY config/hhvm.conf /etc/nginx/hhvm.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/php.ini /etc/hhvm/php.ini

RUN chmod 777 /var/log/nginx/*.log

# For faster localdev builds, comment out the COPY, "chown",
# ARG, composer, and ReltypeCompiler lines, since you'll be
# using a volume to get your source code, these lines do
# nothing useful for you.
COPY . /app
RUN chown -R app:app /app # Because "COPY" doesn't respect Docker "USER" command

USER app
ENV TZ America/Los_Angeles

WORKDIR /app/www

CMD /app/entrypoint.sh
