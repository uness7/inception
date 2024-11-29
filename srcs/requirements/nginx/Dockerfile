FROM alpine:latest

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /var/www/html/

COPY /src/html/index.html /var/www/html/index.html

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/yzioual.crt \
       -keyout /etc/nginx/ssl/yzioual.key \
       -subj "/C=FR/ST=LeHavre/L=LeHavre/O=42 School/OU=yzioual/CN=yzioual/"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
