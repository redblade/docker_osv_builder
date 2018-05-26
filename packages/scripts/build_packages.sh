#!/bin/bash

if [ "$1" == "" ]
then
  echo "Usage: build_packages.sh <package_name>|all"
  exit 1
fi

source $(dirname $0)/commons.sh

build_all_packages() {
  build_osv_loader_and_boostrap_package # kernel + common bootstrap
  build_run_java_package # bootstrap for JREs (Java Runtime Environment)
  build_run_go_package # bootstrap for Golang apps 
  build_node_package # Node.JS runtime
  build_openjdk10-java-base_package # Minimal (java.base) OpenJDK JRE -> depends on run_java

  build_httpserver_api_package # helper httpserver app
  build_httpserver_html5_gui_package # OSv gui -> depends on httpserver_api
  build_httpserver_html5_cli_package # OSv HTML5 terminal -> depends on httpserver_api
  build_cli_package #OSv clasical terminal -> depends on httpserver_api

  build_lighttpd_package # app
  build_nginx_package # app
  build_iperf_package # app
  build_netperf_package # app
  build_redis_package # app
  build_memcached_package # app
  build_mysql_package # app
}

case "$1" in
  all)
    echo "Building all packages ..."
    build_all_packages;;
  osv_loader_and_boostrap|run_java|run_go|node|openjdk10-java-base|httpserver_api|\
  httpserver_html5_gui|httpserver_html5_cli|cli|lighttpd|nginx|iperf|netperf|redis|memcached|mysql)
    echo "Building package $1 ..."
    build_$1_package;;
  *)
    echo "Unrecognised which package to build!"
esac
