# https://registry.hub.docker.com/_/nginx/
FROM nginx:latest

# 設定ファイルをコピー
COPY nginx.conf /etc/nginx/

# HTMLファイルをコピー
COPY index.html /usr/share/nginx/html/
RUN mkdir /usr/share/nginx/html/tutorial
COPY help.html /usr/share/nginx/html/tutorial
