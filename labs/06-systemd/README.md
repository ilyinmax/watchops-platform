# Тема 06 — systemd, journal и logrotate

## Цель

Научиться запускать собственный процесс как `systemd`-сервис, настраивать его окружение, рабочий каталог, автоматический перезапуск и запуск после перезагрузки системы, а также диагностировать проблемы через `systemctl` и `journalctl`.

Дополнительно настроены периодическая задача через `systemd timer` и ротация файлового журнала через `logrotate`.

## Что было сделано

### systemd-сервис

Для лаборатории создан процесс-заглушка WatchOps, который периодически выводит heartbeat.

Для него настроен unit `watchops-stub.service`:

* запуск от непривилегированного пользователя;
* `WorkingDirectory`;
* переменная `WATCHOPS_INTERVAL`;
* `ExecStart`;
* `Restart=on-failure`;
* задержка между попытками перезапуска;
* автозапуск через `multi-user.target`.

После `systemctl enable` сервис успешно запускался автоматически после перезагрузки VM.

### Restart policy

Было проверено различие между нормальным и аварийным завершением процесса.

При завершении процесса через `SIGTERM` systemd считал остановку успешной и не выполнял автоматический перезапуск.

При аварийном завершении через `SIGKILL` с настроенным:

```ini
Restart=on-failure
RestartSec=2
```

systemd обнаруживал failure и создавал новый процесс с новым PID.

## Диагностика systemd

Для диагностики использовались:

```bash
systemctl status <service>
systemctl cat <service>
systemctl show <service>
journalctl -u <service>
```

Во время лаборатории были разобраны ошибки:

### `203/EXEC`

systemd не смог выполнить команду из `ExecStart`.

В лаборатории причиной было неправильное имя исполняемого файла.

### `200/CHDIR`

systemd не смог перейти в каталог, заданный через `WorkingDirectory`.

После исправления рабочего каталога процесс успешно запускался.

## Самостоятельный босс

Был восстановлен намеренно сломанный `watchops-boss.service`.

Необходимо было исправить:

* пользователя запуска;
* рабочий каталог;
* environment-переменные;
* параметры restart policy;
* путь к исполняемому файлу.

Итоговая конфигурация использовала:

```ini
User=maxim
WorkingDirectory=/home/maxim/watchops-systemd-lab/boss
Environment=WATCHOPS_MODE=production
Environment=WATCHOPS_INTERVAL=4
Restart=on-failure
RestartSec=2
```

После исправления было проверено:

* сервис находится в `active (running)`;
* heartbeat появляется каждые 4 секунды;
* после аварийного завершения создаётся новый PID;
* после reboot сервис запускается автоматически.

## systemd timer

Создан `watchops-check.timer`, периодически запускающий одноразовый `watchops-check.service`.

`watchops-check.service` использует:

```ini
Type=oneshot
```

Поэтому после успешного выполнения состояние `inactive (dead)` является нормальным: процесс уже завершился, а следующего запуска ожидает сам timer.

Timer настроен на периодический запуск проверки состояния основного WatchOps-сервиса.

## Journal

Вывод сервисов просматривался через:

```bash
journalctl -u watchops-stub.service
journalctl -u watchops-boss.service
journalctl -b
```

`journalctl` читает журнал, который ведёт `systemd-journald`.

Журнал может храниться:

* временно в `/run/log/journal`;
* постоянно в `/var/log/journal`.

Файлы journal имеют бинарный формат и обычно читаются через `journalctl`, а не напрямую через `cat`.

## Файловые логи и logrotate

Для `watchops-check.service` stdout и stderr были направлены в:

```text
/var/log/watchops-lab/check.log
```

Для этого файла настроен `logrotate`:

```text
daily
rotate 5
compress
delaycompress
missingok
notifempty
create 0640 maxim maxim
```

Принудительная тестовая ротация выполнялась через:

```bash
sudo logrotate -f /etc/logrotate.d/watchops-lab
```

После неё старый журнал перемещался в `check.log.1`, а новый `check.log` создавался для последующих записей.

## Важные выводы

* `systemctl start` запускает сервис сейчас, а `systemctl enable` настраивает его запуск при последующих загрузках системы.
* После изменения unit-файла необходимо выполнить `systemctl daemon-reload`, чтобы PID 1 перечитал конфигурацию.
* `daemon-reload` не перезапускает работающий сервис.
* `ExecStart` определяет, какую программу запускать.
* `WorkingDirectory` задаёт текущий каталог процесса и необязательно совпадает с каталогом исполняемого файла.
* `Restart=on-failure` не исправляет первопричину сбоя и при постоянной ошибке может создать restart loop.
* `journalctl` используется для просмотра journal.
* `logrotate` не читает логи, а управляет ротацией обычных файлов журналов.
* `Type=oneshot` предназначен для задач, которые выполняются и завершаются.
* Статус сервиса и его journal нужно проверять до изменения конфигурации.

## Структура лаборатории

```text
06-systemd/
├── README.md
├── logrotate/
│   └── watchops-lab
├── scripts/
│   ├── watchops-check.sh
│   └── watchops-stub.sh
└── systemd/
    ├── watchops-boss.service
    ├── watchops-check.service
    ├── watchops-check.timer
    └── watchops-stub.service
```
