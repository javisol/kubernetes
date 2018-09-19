kubectl create cm front-nginx-logs-auth --from-file configMaps/nginx-htpasswd #javi:javi
kubectl create cm front-nginx-logs-config --from-file configMaps/default.conf
kubectl create cm front-nginx-logs-index --from-file configMaps/index.html
