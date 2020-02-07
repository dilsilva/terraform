#!/BIN/BASH
docker build -t juvo-nginx .
docker tag juvo-nginx dilsilva/juvo-nginx:1.0
docker push dilsilva/juvo-nginx:1.0
docker run --name juvo-nginx-run -p 8080:80 dilsilva/juvo-nginx:1.0
curl http://localhost:8080