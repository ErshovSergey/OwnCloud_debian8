# ownCloud

[ownCloud](https://owncloud.org/) в контейнере docker
# Как использовать этот образ
В настоящий момент только SQLite в качестве БД.
## Собрать образ
```shell
docker build --rm=true --force-rm --tag=ershov/owncloud .
```
## Подготовка
###Папка для хранения
```shell
export SHARE_DIR="/var/lib/mnt_point/4Tb/docker/OwnCloud"
mkdir -p $SHARE_DIR $SHARE_DIR
chgrp -R 33 $SHARE_DIR
chmod -R 0770 $SHARE_DIR
```
### Доступ на ip адреса
```shell
export ip_addr=192.168.0.184
```
##Запустить образ
```shell
docker run --name OwnCloud -h fqdn.hostname.host \
-ti --restart=always \
-v $SHARE_DIR:/var/www/owncloud/data \
-p $ip_addr:1280:80 \
-d ershov/owncloud
```
##Настройки 
 - часовой пояс настраивается в файле *add/entrypoint.sh*
