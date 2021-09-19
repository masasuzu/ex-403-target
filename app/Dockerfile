FROM perl:5.34.0-slim
RUN cpanm Plack
ADD app.psgi /opt/app/app.psgi
CMD ["plackup", "/opt/app/app.psgi"]

EXPOSE 5000/tcp