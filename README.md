# nluzgin_infra
nluzgin Infra repository


ДЗ №5

Задание:
Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства

Решение:
ssh -Ai ~/.ssh/id_rsa nluzgin@35-195-179-208 -t shh 10.132.0.3


Задание:
Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost 

Решение:
Создать алиас в конфиге shh:

Host someinternalhost
	HostName 35-195-179-208
    User nluzgin
    IdentityFIle ~/.ssh/id_rsa
	ForwardAgent yes
	RequestTTY force
	RemoteCommand ssh 10.132.0.3


Задание:
С помощью сервисов / и реализуйте использование валидного сертификата для панели управления VPN-сервера

Решение:
Выпустить серт для https://35-195-179-208.sslip.io (не хватило времени, сделаю чуть позже)


bastion_IP = 35.195.179.208
someinternalhost_IP = 10.132.0.3


ДЗ №6


testapp_IP = 35.204.193.111
testapp_port = 9292

Создание правил FW из командной строки

gcloud compute firewall-rules create default-puma-server \
	--direction=IN \
	--rules=tcp:9292 \
	--source-ranges=0.0.0.0/0 \
	--action=ALLOW \
	--priority=1000 \
	--target-tags=puma-server \
	--network=default

ДЗ №7
- Создан базовый образ с ruby & mongo на борту с помощью packer
- Создан полный образ приложения reddit на основе базового образа
- Создан sh скрипт разворачивающий инстанс с приложением reddit, который использует предсконфигурированный образ, созданный с помощью packer
