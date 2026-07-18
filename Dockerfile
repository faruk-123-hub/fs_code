FROM nginx:alpine

COPY README.md /usr/share/nginx/html/index.html

LABEL author="faruk"
LABEL version="1.0"

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
