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

ДЗ №8
- Установлен terraform
- Изучены основные команды terraform
- Сконфигурированы файлы для terraform, позволяющие создать compute engine в GC
- С помощью terraform развёрнуто приложение reddit

Задание с *

- Добавьте в веб интерфейсе ssh ключ пользователю appuser_web в метаданные проекта. Выполните terraform apply и проверьте результат Какие проблемы вы обнаружили? 

После применения конфигурации terraform ssh ключи перезатираются.


Задание с **

Балансер с ip forwarding:

1) создание HTTP балансировщика

resource "google_compute_target_pool" "reddit-app-pool" 
+
resource "google_compute_http_health_check" "reddit-app-pool_hc"
+
resource "google_compute_forwarding_rule" "reddit-app-forwarding"

Вывод в лог value = google_compute_forwarding_rule.reddit-app-forwarding.ip_address

2) 2 приложения с помощью count
Имя "${var.app_name}-${count.index}"
+ count = var.count_of_applications


ДЗ №9
- Изучена работа с terraform import
- Изучены работа с terraform modules

Задание с *

- Настройте хранение стейт файла в удаленном бекенде (remote backends) для окружений stage и prod, используя Google Cloud Storage в качестве бекенда

Файлы *.tfstate теперь хранятся в GCS


Задание с **
- Добавьте необходимые provisioner в модули для деплоя и работы приложения
Добавил провиженеры и выставляю переменную окружения DATABASE_URL == ip инстанса с БД + порт 27017

