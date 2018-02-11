FROM scratch
ADD ca-certificates.crt /etc/ssl/certs/
ADD app /
EXPOSE 8080
CMD ["/app"]