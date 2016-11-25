# kubernetes_scripts

### chg_hosts.sh
Script to change /etc/host file in a kubernetes POD in base of a service name or external domain.
It will search for "SERVICENAME_SERVICE_HOST" to take the ip in case of internal k8s service, in case of external domain you have to add EXT_SERVICENAME as a env parameter where "SERVICENAME" is the service name lke (chef, mongodb, etc...).
