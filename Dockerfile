FROM nginx as base
WORKDIR /usr/share/nginx/html
EXPOSE 80

FROM base
COPY /build/web/ .
VOLUME [ "/usr/share/nginx/html" ]