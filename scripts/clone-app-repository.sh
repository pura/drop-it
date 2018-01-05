#!/bin/bash

echo "Cloning Repository ..."
echo ""

if [[ $(minikube status | grep 'minikube: Stopped') == 'minikube: Stopped' ]]; then
  echo "ERROR: Minikube is not running"
fi

if [[ $(minikube status | grep 'minikube: Running') == 'minikube: Running' ]]; then
  echo ""
  PHPCONTAINER="$(kubectl get pods | grep -o -E '^dropit-[0-9a-z\-]+') --container dropit-app"
  kubectl exec -it ${PHPCONTAINER} -- git clone https://github.com/symfony/symfony-standard.git /var/www/html/drop-it
  kubectl exec -it ${PHPCONTAINER} -- chmod -R 777 /var/www/html/drop-it/var/cache/ /var/www/html/drop-it/var/logs/ /var/www/html/drop-it/var/sessions/
  kubectl exec -it ${PHPCONTAINER} -- composer install
fi

echo ""