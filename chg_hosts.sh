#!/bin/bash

hosts_file="hosts"
service_string="_SERVICE_HOST"
port_string="_SERVICE_PORT"
domain="mysite.com"

declare -a names_arr

names_arr=(service1 service2 service3)

for i in ${names_arr[@]};do
  grep $i $hosts_file > /dev/null
  if [ $? -ne 0  ];then
    var_uppercase=$(echo $i | awk '{print toupper($0)}')
    # Adding k8s service host ip to etc/hosts
    k8s_host_var="$var_uppercase$service_string"
    echo $k8s_host_var
    k8s_port_var="$var_uppercase$service_string"
    env | grep $k8s_host_var
    if [ $? -eq 0 ];then
      echo "${!k8s_host_var} $i $i.$domain" >> $hosts_file
    fi
  fi
done

# Adding external service host ip to etc/hosts
for i in $(env | grep EXT);do
  ext_host_var=$(echo $i | awk -F "=" '{print $1}')
  app_str=$(echo $ext_host_var | awk -F "_" '{print tolower($2)}')
  echo "${!ext_host_var} $app_str $app_str.$domain" >> $hosts_file
done
