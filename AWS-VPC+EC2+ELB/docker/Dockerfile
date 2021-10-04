FROM nginx
MAINTAINER diego silva <dilsilva.diego@gmail.com>

#Add custom index file:
WORKDIR /usr/share/nginx/html
COPY index.html index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]