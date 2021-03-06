#!/bin/bash
docker build -t juvo-nginx .
docker tag juvo-nginx dilsilva/juvo-nginx

#Since you were running in a machine that is already logged in on Docker Hub:
docker push dilsilva/juvo-nginx

#Test the functionality:
docker run --name juvo-nginx-run -p 8080:80 -d dilsilva/juvo-nginx
curl http://localhost:8080