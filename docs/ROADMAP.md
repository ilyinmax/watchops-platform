# DevOps → Middle: практический roadmap вокруг WatchOps

## Цель

Максимально быстро выйти на рынок DevOps, не подменяя навык просмотром лекций и копированием готовых решений.

Контрольные точки:

1. **Трудоустраиваемый Intern/Junior DevOps** — после тем 29–33: Linux, сети, Git, Bash/Python, WatchOps, PostgreSQL, Docker и CI/CD.
2. **Strong Junior с набором middle-компетенций** — после тем 34–58. Реальный грейд Middle закрепляется production-опытом, ответственностью и повторяющимися инцидентами.

Ориентир при 20–25 часах в неделю:

- темы 01–16: 5–7 недель;
- темы 17–33: ещё 7–10 недель;
- темы 34–49: ещё 7–10 недель;
- темы 50–58 и финализация: ещё 5–8 недель.

Это не календарное обещание. Переход определяется Definition of Done, а не количеством просмотренных материалов.

## Сквозной проект WatchOps

WatchOps — сервис мониторинга HTTP-целей. По мере обучения он научится:

- хранить список целей;
- периодически проверять их;
- сохранять результаты;
- предоставлять API и health endpoints;
- писать структурированные логи и метрики;
- разворачиваться как Linux-сервис, Docker Compose-стек и Kubernetes-релиз;
- проходить CI/CD;
- создавать инфраструктуру через Terraform и Ansible;
- наблюдаться через Prometheus, Grafana, Loki и OpenTelemetry;
- восстанавливаться из backup;
- иметь security gates, SLO и incident runbooks.

Приложение нужно не ради превращения в backend-разработчика, а чтобы понимать, что DevOps собирает, разворачивает, конфигурирует, наблюдает и восстанавливает.

## Среды

- **Windows 11** — хост.
- **WSL2 Ubuntu** — ежедневный терминал, Git, разработка WatchOps, Docker и локальный Kubernetes.
- **Ubuntu VM в VMware** — отдельный сервер для systemd, SSH, firewall, сетей, дисков, boot, snapshots и разрушительных лабораторий.
- **VDS или одно облако** — production-подобное окружение с этапа CI/CD и IaC.
- **kind/k3d**, затем **k3s или managed Kubernetes** — Kubernetes-стенды.

## Как проходить roadmap

- Один чат = одна тема.
- Команда старта: `Начинаем тему 05.`
- ChatGPT сам берёт из roadmap результат, WatchOps-инкремент, босса, артефакт и Definition of Done.
- В конце темы результат фиксируется в Git и отправляется на GitHub.
- Через 7–14 дней проводится короткая отложенная проверка без чтения старого чата.
- Босс решается без готовой последовательности команд; подсказки усиливаются постепенно.

## Общий Definition of Done

Тема закрыта, когда:

1. Практический результат реально работает.
2. Ты объясняешь ключевые причинно-следственные связи.
3. Самостоятельный босс выполнен без копирования готового решения.
4. Пройдена диагностическая поломка.
5. В GitHub есть проверяемый артефакт и осмысленный commit.
6. Нет секретов, временного мусора и необъяснимых команд.
7. Ты отвечаешь на контрольные вопросы и знаешь, что повторить позже.

---

# Фаза I. Linux и Git — фундамент инженера

**Темы:** 01–09  
**Цель:** уверенно работать в Linux, понимать состояние системы и фиксировать работу в Git.

## Тема 01. Терминал, shell, пути, файлы и каталоги

**Ориентир:** 3–5 часов

**Нужно понять:** терминал и shell; текущий, домашний и корневой каталоги; абсолютные и относительные пути; создание, просмотр, копирование, перемещение и безопасное удаление; скрытые файлы; glob; назначение `/etc`, `/var`, `/home`, `/tmp`, `/opt`, `/proc`.

**Практический результат:** создана и осмысленно реорганизована файловая структура первой лаборатории без графического файлового менеджера.

**Инкремент WatchOps:** создать корень репозитория и каталоги `labs/`, `watchops/`, `incidents/`, `docs/`.

**Босс:** по текстовому ТЗ создать дерево каталогов, переместить ошибочно расположенные файлы, найти скрытый файл и удалить только лишние элементы.

**GitHub-артефакт:** `labs/01-files-and-paths/README.md` с итоговым деревом и объяснением операций.

**Definition of Done:** ты не путаешь `~`, `.`, `..`, `/`; читаешь путь слева направо и выполняешь босса без готовой последовательности.

## Тема 02. Потоки, перенаправления и обработка текста

**Ориентир:** 4–6 часов

**Нужно понять:** stdin/stdout/stderr; `>`, `>>`, `<`, `2>`; pipe; `cat`, `less`, `head`, `tail`, `grep`, `cut`, `sort`, `uniq`, `wc`; основы `find`, `xargs`, `sed`, `awk`; exit code и логические операторы shell.

**Практический результат:** из набора журналов автоматически сформирован компактный отчёт об ошибках и частых событиях.

**Инкремент WatchOps:** создать тестовые логи будущего сервиса и команды их анализа.

**Босс:** не открывая файлы по одному, найти ошибки за период, исключить шум, посчитать повторения и отделить отчёт от ошибок самой команды.

**GitHub-артефакт:** `labs/02-streams-and-text/` с исходными логами, решением и отчётом.

**Definition of Done:** ты понимаешь, что передаётся через pipe, разделяешь обычный вывод и ошибки и проверяешь exit code.

## Тема 03. Пользователи, группы, права и sudo

**Ориентир:** 4–6 часов

**Нужно понять:** UID/GID; owner/group/others; права `rwx`; права на файл и каталог; `chmod`, `chown`, `chgrp`; числовая и символьная запись; `umask`; `sudo`; least privilege.

**Практический результат:** конфигурация читается сервисом, логи записываются сервисом, а посторонний пользователь не меняет критичные файлы.

**Инкремент WatchOps:** подготовить пользователей и каталоги будущего системного сервиса.

**Босс:** исправить несколько `Permission denied`, не используя `777` и не делая весь каталог владельцем root.

**GitHub-артефакт:** `labs/03-users-and-permissions/README.md` с моделью доступа.

**Definition of Done:** ты можешь предсказать результат доступа до выполнения команды и объяснить права на каталог.

## Тема 04. Процессы, сигналы и ресурсы

**Ориентир:** 4–6 часов

**Нужно понять:** PID/PPID; foreground/background; jobs; состояния процессов; `ps`, `top`/`htop`, `pgrep`, `pkill`; TERM/KILL/HUP/INT; CPU, RAM, load average; `lsof`; занятый порт.

**Практический результат:** найден процесс, создающий нагрузку или удерживающий ресурс, установлено его происхождение и выполнено корректное завершение.

**Инкремент WatchOps:** запустить процесс-заглушку и научиться находить его по имени, PID, порту и открытому файлу.

**Босс:** диагностировать зависший процесс, занятый порт и процесс, не завершающийся обычным сигналом.

**GitHub-артефакт:** `labs/04-processes/incident.md` с симптомами, гипотезами и исправлением.

**Definition of Done:** ты не начинаешь с `kill -9` и различаешь симптом нагрузки и первопричину.

## Тема 05. Пакеты, диски, файловые системы и архивы

**Ориентир:** 4–6 часов

**Нужно понять:** APT и репозитории; устройство/раздел/файловая система/mount point; `lsblk`, `df`, `du`, `findmnt`; inode; `tar` и gzip; временные каталоги; безопасная очистка.

**Практический результат:** определена причина заполнения диска, данные архивированы и место освобождено без потери нужных файлов.

**Инкремент WatchOps:** организовать архивирование тестовых логов и проверку свободного места.

**Босс:** разобрать стенд, где `df` и `du` дают неожиданно разные картины, а часть места удерживает процесс.

**GitHub-артефакт:** `labs/05-storage-and-packages/` со скриптом проверки и описанием восстановления.

**Definition of Done:** ты различаешь размер каталога, свободное место и inode; проверяешь архив до удаления оригинала.

## Тема 06. systemd, journal и logrotate

**Ориентир:** 5–7 часов

**Нужно понять:** unit/service/target; PID 1; `systemctl`; структура unit-файла; рабочий каталог; environment; restart policy; зависимости; `journalctl`; systemd timer; logrotate.

**Практический результат:** собственный процесс запускается как systemd-сервис, восстанавливается после падения и пишет диагностируемые логи.

**Инкремент WatchOps:** использовать простой процесс-заглушку, позднее заменяемый настоящим WatchOps.

**Босс:** исправить unit с неверным пользователем, рабочим каталогом, переменной окружения и политикой перезапуска.

**GitHub-артефакт:** `labs/06-systemd/` с unit, timer/logrotate и runbook.

**Definition of Done:** после перезагрузки VM сервис запускается, а причину отказа ты находишь через status и journal.

## Тема 07. Git: рабочая директория, индекс и коммиты

**Ориентир:** 4–6 часов

**Нужно понять:** repository; working tree; staging area; commit; `init`, `status`, `add`, `commit`, `log`, `diff`; HEAD; `.gitignore`; атомарный commit; безопасное восстановление файлов.

**Практический результат:** учебный репозиторий ведётся осмысленными коммитами, изменения можно сравнивать и восстанавливать.

**Инкремент WatchOps:** добавить базовый README и начать историю единого репозитория.

**Босс:** разделить смешанные изменения на логические commits и восстановить случайно изменённый файл.

**GitHub-артефакт:** история Git с понятными сообщениями и `.gitignore`.

**Definition of Done:** перед commit ты понимаешь содержимое индекса и отличаешь working tree, index и HEAD.

## Тема 08. Ветки, merge, конфликты и GitHub

**Ориентир:** 5–7 часов

**Нужно понять:** branch; `switch`; merge; fast-forward; merge commit; conflict; `revert`; remote; fetch/pull/push; pull request; code review; когда rebase допустим.

**Практический результат:** изменение сделано в отдельной ветке, конфликт разрешён вручную, результат объединён через pull request.

**Инкремент WatchOps:** использовать `feature/...` для первого изменения проекта.

**Босс:** сымитировать параллельные изменения одного файла, сохранить обе полезные части и отменить плохой commit через revert.

**GitHub-артефакт:** закрытый pull request и история с merge/revert.

**Definition of Done:** ты понимаешь fetch, pull и merge и не используешь force push без осознанной причины.

## Тема 09. Босс Linux: эксплуатация небольшого сервиса

**Ориентир:** 7–10 часов

**Нужно понять:** интеграцию файлов, прав, процессов, пакетов, systemd, журналов и Git; алгоритм «симптом → факты → гипотеза → проверка → исправление»; runbook.

**Практический результат:** на чистой Ubuntu VM установлен сервис, создан отдельный пользователь, настроены права, автозапуск, журналирование и ротация.

**Инкремент WatchOps:** инфраструктурный прототип будущего окружения WatchOps.

**Босс:** получить стенд с четырьмя независимыми проблемами и восстановить его без готовых команд.

**GitHub-артефакт:** `labs/09-linux-boss/` с конфигурациями, installation notes, runbook и incident report.

**Definition of Done:** ты воспроизводишь стенд с чистой VM и объясняешь каждую привилегированную операцию.

---
# Фаза II. Сети и публикация сервисов

**Темы:** 10–16  
**Цель:** понимать путь запроса и диагностировать доступность от клиента до процесса.

## Тема 10. Модель TCP/IP, IPv4 и CIDR

**Ориентир:** 4–6 часов

**Нужно понять:** практический смысл уровней TCP/IP и OSI; IPv4; network/host bits; mask/CIDR; private/public/loopback/link-local; network и broadcast; диапазон хостов; MAC и ARP на необходимом уровне.

**Практический результат:** для нескольких подсетей вручную и инструментами определены адрес сети, broadcast, диапазон и принадлежность хоста.

**Инкремент WatchOps:** нарисовать схему Windows → WSL → VM → будущий WatchOps.

**Босс:** исправить ошибочный план адресации, из-за которого узлы считают друг друга удалёнными.

**GitHub-артефакт:** `labs/10-ip-cidr/network-plan.md` со схемой и расчётами.

**Definition of Done:** ты объясняешь назначение маски и можешь определить локального или маршрутизируемого получателя.

## Тема 11. TCP, UDP, порты, сокеты, маршруты и NAT

**Ориентир:** 5–7 часов

**Нужно понять:** TCP handshake и состояния; UDP; порт и socket; listening process; route/default gateway; NAT, SNAT/DNAT и port forwarding; `ip`, `ss`, `nc`, основы `tcpdump`.

**Практический результат:** путь запроса от клиента к процессу описан по адресам, маршрутам, портам и NAT.

**Инкремент WatchOps:** запустить временный HTTP-процесс на VM и проверить его из WSL и Windows.

**Босс:** найти, почему сервис слушает только локально, и отдельно — почему трафик уходит не через тот маршрут.

**GitHub-артефакт:** `labs/11-tcp-routing/incident.md` с сетевой трассировкой.

**Definition of Done:** ты различаешь «порт не слушается», «маршрута нет», «фильтрация» и «приложение не отвечает».

## Тема 12. DNS и разрешение имён

**Ориентир:** 4–6 часов

**Нужно понять:** stub/recursive resolver; authoritative DNS; delegation; A/AAAA/CNAME/NS/MX/TXT; TTL и cache; `dig`, `resolvectl`, `nslookup`, `/etc/hosts`; типовые DNS-сбои.

**Практический результат:** диагностирована ситуация, где сервис доступен по IP, но недоступен по имени.

**Инкремент WatchOps:** добавить тестовое имя для лабораторного сервиса и проверить всю цепочку разрешения.

**Босс:** разобрать неверную запись, устаревший cache и различие ответов двух DNS-серверов.

**GitHub-артефакт:** `labs/12-dns/dns-runbook.md`.

**Definition of Done:** ты сначала устанавливаешь, какой resolver использует клиент и какой ответ он получает.

## Тема 13. HTTP, HTTPS и TLS

**Ориентир:** 5–7 часов

**Нужно понять:** request/response; method, URL, headers, body; коды 1xx–5xx; redirect; timeout; TLS handshake; CA; SAN; срок сертификата; `curl -v`; `openssl s_client`.

**Практический результат:** HTTP-сервис проверен на уровнях DNS, TCP, TLS и HTTP, причины разных ошибок разделены.

**Инкремент WatchOps:** определить контракт `/health/live`, `/health/ready` и базового API.

**Босс:** найти причину ошибки сертификата, неправильного redirect и ответа 503, не смешивая их.

**GitHub-артефакт:** `labs/13-http-tls/http-checklist.md`.

**Definition of Done:** ты читаешь verbose-вывод curl по этапам и точно называешь этап отказа.

## Тема 14. SSH и безопасное удалённое администрирование

**Ориентир:** 4–6 часов

**Нужно понять:** SSH client/server; host key; private/public key; `authorized_keys`; права `.ssh`; SSH config; agent; ProxyJump и forwarding на базовом уровне; hardening sshd.

**Практический результат:** WSL подключается к VM по короткому алиасу только по ключу; пароль отключается лишь после проверки ключевого входа.

**Инкремент WatchOps:** подготовить канал администрирования staging-сервера.

**Босс:** восстановить доступ при неверных правах, пользователе и старом host key, не отключая проверки безопасности.

**GitHub-артефакт:** `labs/14-ssh/README.md` без ключей и секретов.

**Definition of Done:** ты никогда не публикуешь private key и понимаешь назначение fingerprint сервера.

## Тема 15. Firewall и Nginx reverse proxy

**Ориентир:** 6–8 часов

**Нужно понять:** inbound/outbound и stateful firewall; UFW/nftables на базовом уровне; web server/reverse proxy; Nginx server/location/upstream; proxy headers; access/error logs; TLS termination; 403/404/502/504.

**Практический результат:** внутренний сервис опубликован через Nginx, а firewall оставляет только необходимые входящие порты.

**Инкремент WatchOps:** создать будущий внешний вход через Nginx и сохранить конфигурацию в Git.

**Босс:** исправить закрытый порт, неверный upstream, bind на localhost и отсутствующий proxy header.

**GitHub-артефакт:** `labs/15-nginx-firewall/` с конфигурацией и схемой потока запроса.

**Definition of Done:** ты прослеживаешь запрос от клиента до процесса и знаешь журнал для каждого класса ошибки.

## Тема 16. Босс сетей: сервис недоступен

**Ориентир:** 7–10 часов

**Нужно понять:** единый порядок DNS → route → TCP → TLS → HTTP → proxy → application; сбор минимально достаточных фактов.

**Практический результат:** восстановлен недоступный сервис с несколькими независимыми проблемами на разных слоях.

**Инкремент WatchOps:** стенд имитирует будущую публикацию WatchOps.

**Босс:** получить только пользовательский симптом и локализовать не менее пяти проблем без списка возможных причин.

**GitHub-артефакт:** `incidents/network-01/` с timeline, root cause, fix и prevention.

**Definition of Done:** после каждого шага ты можешь сформулировать, что проверено и что исключено.

---
# Фаза III. Автоматизация и WatchOps с нуля

**Темы:** 17–22  
**Цель:** освоить Bash и необходимый Python, затем создать минимальное реальное приложение.

## Тема 17. Bash для автоматизации

**Ориентир:** 6–8 часов

**Нужно понять:** shebang; переменные и quoting; аргументы; условия, циклы и функции; массивы на базовом уровне; exit codes; `set -Eeuo pipefail`; `trap`; временные файлы; логирование; идемпотентность.

**Практический результат:** написан надёжный CLI-скрипт проверки хоста с понятными exit codes и логами.

**Инкремент WatchOps:** создать `scripts/check-host.sh`, проверяющий диск, память, процесс, порт и HTTP endpoint.

**Босс:** сделать скрипт безопасным при пробелах, отсутствующих переменных, частичном отказе и повторном запуске.

**GitHub-артефакт:** `scripts/check-host.sh`, тестовые сценарии и README.

**Definition of Done:** скрипт не скрывает ошибку успешным кодом и проходит ShellCheck или осмысленный ручной разбор.

## Тема 18. Python для DevOps-автоматизации

**Ориентир:** 7–10 часов

**Нужно понять:** типы и коллекции; условия, циклы, функции; модули; virtual environment; исключения; файлы; JSON/YAML; HTTP-клиент; `argparse`; `logging`; `subprocess`; зависимости; минимальные тесты.

**Практический результат:** создана Python CLI-утилита, проверяющая список URL и сохраняющая структурированный отчёт.

**Инкремент WatchOps:** первый исполняемый компонент — проверка HTTP-целей.

**Босс:** обработать timeout, неверный URL, невалидный config и частичный успех без падения всего запуска.

**GitHub-артефакт:** `watchops/` с Python-пакетом, `pyproject.toml`, тестами и CLI.

**Definition of Done:** ты понимаешь каждую зависимость, не используешь голый `except` и можешь добавить новый тип проверки.

## Тема 19. Архитектура приложения, конфигурация и логирование

**Ориентир:** 5–7 часов

**Нужно понять:** процесс приложения; bind address; development/production mode; variables/environment; `.env` и `.env.example`; секреты; dependency management; structured logging; graceful shutdown.

**Практический результат:** WatchOps получает настройки извне, валидирует их при старте и пишет структурированные логи без секретов.

**Инкремент WatchOps:** выделить модули config, logging и checks; описать цели и интервалы.

**Босс:** исправить отсутствие переменной, неверный тип, утечку секрета в лог и bind только на localhost.

**GitHub-артефакт:** config-модуль, `.env.example`, документация и тесты валидации.

**Definition of Done:** один код запускается в разных средах без редактирования исходников.

## Тема 20. FastAPI и минимальный WatchOps API

**Ориентир:** 7–10 часов

**Нужно понять:** HTTP API; route и schema; sync/async на необходимом уровне; validation; dependency injection FastAPI на базовом уровне; liveness/readiness; обработка ошибок; OpenAPI.

**Практический результат:** WatchOps предоставляет API списка целей, запуска проверки и получения результата; есть `/health/live` и `/health/ready`.

**Инкремент WatchOps:** создать минимальную версию приложения без лишней бизнес-логики.

**Босс:** добавить endpoint по спецификации без готового кода, корректно обработать невалидные данные и ошибку внешней цели.

**GitHub-артефакт:** API, тесты endpoints и архитектурная схема.

**Definition of Done:** ты объясняешь путь запроса внутри приложения и различаешь liveness/readiness.

## Тема 21. PostgreSQL, SQL, миграции и backup

**Ориентир:** 8–12 часов

**Нужно понять:** таблица, строка, ключ, constraint и index; SELECT/INSERT/UPDATE/DELETE; transaction; connection и pool; роли и права; ORM по назначению; миграция схемы; `pg_dump` и restore.

**Практический результат:** WatchOps сохраняет цели и результаты в PostgreSQL; схема управляется миграциями; backup реально восстановлен.

**Инкремент WatchOps:** модели Target и CheckResult, миграции и слой доступа к данным.

**Босс:** изменить схему без потери данных, исправить права БД и восстановить данные в новый экземпляр.

**GitHub-артефакт:** миграции, модели, backup/restore scripts и доказательство восстановления.

**Definition of Done:** ты не меняешь production-схему вручную без миграции и понимаешь последствия rollback.

## Тема 22. Босс приложения: WatchOps как Linux-сервис

**Ориентир:** 8–12 часов

**Нужно понять:** интеграцию Python, FastAPI, PostgreSQL, systemd, конфигурации, логов и Nginx; startup dependencies; readiness; эксплуатационную документацию.

**Практический результат:** WatchOps установлен на VM как systemd-сервис, доступен через Nginx и сохраняет данные в PostgreSQL.

**Инкремент WatchOps:** версия `v0.1.0` — первый полноценный неконтейнерный релиз.

**Босс:** развернуть на чистой VM по собственному README, затем исправить проблемы config, прав БД, systemd и proxy.

**GitHub-артефакт:** tag `v0.1.0`, deployment guide, runbook и incident report.

**Definition of Done:** другой человек может развернуть v0.1 по README; после reboot система возвращается в работу.

---

# Фаза IV. Контейнеры

**Темы:** 23–28  
**Цель:** контейнеризировать WatchOps и научиться диагностировать runtime, сети и постоянные данные.

## Тема 23. Контейнеры, образы и Docker runtime

**Ориентир:** 5–7 часов

**Нужно понять:** container против VM; image/layer/container/registry; namespaces и cgroups концептуально; lifecycle; pull/run/stop/rm/logs/exec/inspect; port publishing; environment.

**Практический результат:** готовые образы запущены, исследованы и диагностированы без восприятия контейнера как маленькой VM.

**Инкремент WatchOps:** сформулировать требования к будущему контейнеру приложения.

**Босс:** найти немедленное завершение контейнера, занятый порт и неверную переменную окружения.

**GitHub-артефакт:** `labs/23-docker-runtime/README.md`.

**Definition of Done:** ты понимаешь, почему контейнер живёт, пока жив его основной процесс.

## Тема 24. Dockerfile и воспроизводимый образ

**Ориентир:** 6–9 часов

**Нужно понять:** build context; `.dockerignore`; `FROM`, `WORKDIR`, `COPY`, `RUN`, `ENV`, `USER`; `CMD` и `ENTRYPOINT`; cache layers; multi-stage build; non-root; tag и digest.

**Практический результат:** создан небольшой, безопасный и воспроизводимый образ WatchOps.

**Инкремент WatchOps:** контейнеризировать API/CLI без секретов и локального окружения в image.

**Босс:** уменьшить image, убрать root, исправить порядок слоёв и корректно обработать shutdown.

**GitHub-артефакт:** `Dockerfile`, `.dockerignore`, build/run guide и сравнение размеров.

**Definition of Done:** сборка повторяется с чистого cache, приложение запускается non-root, config приходит на runtime.

## Тема 25. Docker storage: bind mounts и volumes

**Ориентир:** 4–6 часов

**Нужно понять:** writable layer; bind mount; named volume; UID/GID; read-only mount; backup/restore volume; данные приложения и БД.

**Практический результат:** данные PostgreSQL сохраняются после пересоздания контейнера и восстанавливаются из копии.

**Инкремент WatchOps:** перенести БД и конфигурацию в правильные типы хранилищ.

**Босс:** исправить потерю данных, перекрытие каталога mount-ом и `Permission denied` без запуска всего от root.

**GitHub-артефакт:** `labs/25-docker-storage/` со сценарием backup/restore.

**Definition of Done:** ты заранее знаешь, что исчезнет после `docker rm`, а что останется.

## Тема 26. Docker networks и service discovery

**Ориентир:** 5–7 часов

**Нужно понять:** bridge network; container IP; DNS-имя сервиса; published/exposed port; localhost внутри контейнера; несколько сетей; диагностика DNS/TCP.

**Практический результат:** WatchOps соединяется с PostgreSQL по имени сервиса, наружу открыт только нужный вход.

**Инкремент WatchOps:** разделить proxy/frontend и backend/data networks.

**Босс:** найти неверный hostname, bind на loopback, отсутствующую сеть и ненужную публикацию БД.

**GitHub-артефакт:** схема контейнерных сетей и лабораторный стенд.

**Definition of Done:** ты не используешь container IP как постоянный адрес и различаешь localhost хоста и контейнера.

## Тема 27. Docker Compose и многосервисный стек

**Ориентир:** 6–9 часов

**Нужно понять:** project/service/network/volume; environment и env file; healthcheck; dependency против readiness; restart policy; `docker compose config/up/down/logs/exec`; profiles/overrides на базовом уровне.

**Практический результат:** WatchOps, PostgreSQL и Nginx запускаются одной декларативной конфигурацией.

**Инкремент WatchOps:** версия `v0.2.0` — локальный Compose-стек с healthchecks и persistent data.

**Босс:** собрать Compose-файл по требованиям без готового YAML и добиться корректного холодного старта.

**GitHub-артефакт:** `compose.yaml`, Nginx config, `.env.example`, README и tag `v0.2.0`.

**Definition of Done:** `docker compose up -d` на чистой машине приводит систему в работу, `config` валиден.

## Тема 28. Босс Docker: диагностика сломанного стека

**Ориентир:** 8–12 часов

**Нужно понять:** порядок container → process → config → DNS → TCP → application → storage; restart loop; OOM; unhealthy; permission; port conflict.

**Практический результат:** восстановлен Compose-стек с несколькими скрытыми неисправностями.

**Инкремент WatchOps:** эксплуатационный экзамен версии v0.2.

**Босс:** исправить минимум шесть проблем без заранее известного списка и без полного пересоздания как универсального ответа.

**GitHub-артефакт:** `incidents/docker-01/` с postmortem и исправляющими commits.

**Definition of Done:** для каждой проблемы доказана root cause, а не только найдена команда, после которой стало работать.

---
# Фаза V. CI/CD, серверы и Infrastructure as Code

**Темы:** 29–38  
**Цель:** автоматизировать проверки, сборку, публикацию, развёртывание и создание инфраструктуры.

## Тема 29. CI и GitHub Actions

**Ориентир:** 6–9 часов

**Нужно понять:** CI; workflow/event/job/step/runner; checkout; environment; exit code; secrets и permissions; matrix на базовом уровне; pull request checks.

**Практический результат:** на push и pull request автоматически запускаются проверки WatchOps.

**Инкремент WatchOps:** workflow установки зависимостей, lint и tests.

**Босс:** написать workflow по требованиям и исправить различие поведения локально и на runner.

**GitHub-артефакт:** `.github/workflows/ci.yml`, badge и политика веток.

**Definition of Done:** сломанный тест блокирует merge, секреты не печатаются, permissions минимальны.

## Тема 30. Качество pipeline: cache, artifacts и тестовая БД

**Ориентир:** 5–7 часов

**Нужно понять:** cache против artifact; reproducible dependencies; service containers; test database; coverage/quality gate; parallel jobs; failure diagnostics.

**Практический результат:** pipeline воспроизводимо тестирует WatchOps с PostgreSQL и сохраняет полезные артефакты.

**Инкремент WatchOps:** integration tests, coverage и диагностические логи при failure.

**Босс:** ускорить pipeline без опасного cache и устранить flaky test.

**GitHub-артефакт:** обновлённые workflows и отчёт надёжности/времени.

**Definition of Done:** ты объясняешь, почему cache безопасен и когда инвалидируется.

## Тема 31. Container Registry, версии и security scanning

**Ориентир:** 6–8 часов

**Нужно понять:** registry/repository image; tag против digest; SemVer и commit SHA; immutable release; authentication; vulnerability scan; SBOM/provenance на базовом уровне; secret scanning.

**Практический результат:** pipeline собирает, сканирует и публикует версионированный image WatchOps.

**Инкремент WatchOps:** публикация в GitHub Container Registry с version/SHA tags.

**Босс:** не допустить публикацию при критической уязвимости или провале тестов и доказать deployed digest.

**GitHub-артефакт:** release workflow, package в registry и release notes.

**Definition of Done:** `latest` не является единственным идентификатором версии; registry secret не попадает в логи.

## Тема 32. CD на VM/VDS и секреты окружения

**Ориентир:** 7–10 часов

**Нужно понять:** deployment environment и promotion; push/pull deployment; SSH deployment; secrets на сервере; smoke test; manual approval; concurrency; audit trail.

**Практический результат:** успешный release автоматически разворачивается на staging VM, затем выполняется smoke test.

**Инкремент WatchOps:** версия `v0.3.0` работает на VM как Compose-стек из опубликованных images.

**Босс:** развернуть новую версию без копирования исходников и не оставить систему в неопределённом состоянии при ошибке.

**GitHub-артефакт:** deployment workflow, server bootstrap notes и tag `v0.3.0`.

**Definition of Done:** из GitHub видно, кто, что и когда развернул; долгоживущий token не лежит открыто на сервере.

## Тема 33. Релизы, миграции и rollback

**Ориентир:** 7–10 часов

**Нужно понять:** release против deployment; rolling/blue-green/canary по назначению; backward-compatible DB migration; health gate; rollback; feature flag на базовом уровне; graceful shutdown.

**Практический результат:** WatchOps обновляется и откатывается по документированной процедуре без потери данных.

**Инкремент WatchOps:** release runbook и безопасная миграция схемы.

**Босс:** выпустить несовместимое изменение в два безопасных этапа и восстановить предыдущую версию после плохого smoke test.

**GitHub-артефакт:** `docs/release-runbook.md`, миграции и post-deploy checks.

**Definition of Done:** rollback приложения не требует невозможного отката уже разрушительно изменённой БД.

> **Контрольная точка:** после тем 29–33 начинай регулярно откликаться на Intern/Junior DevOps, не ожидая Kubernetes.

## Тема 34. Ansible: управление конфигурацией

**Ориентир:** 8–12 часов

**Нужно понять:** inventory/host/group; module/task/play/playbook; idempotency; variables/facts/templates; handlers; roles; become; Vault.

**Практический результат:** чистая Ubuntu VM автоматически превращается в staging-сервер WatchOps.

**Инкремент WatchOps:** Ansible устанавливает Docker, создаёт пользователя/каталоги, размещает config и запускает стек.

**Босс:** добиться второго запуска без лишних changes и убрать ручные server-side действия.

**GitHub-артефакт:** `ansible/` с inventory example, role, playbook и проверкой idempotency.

**Definition of Done:** повторный запуск безопасен; environment отделён от role; секреты защищены.

## Тема 35. Terraform: основы Infrastructure as Code

**Ориентир:** 8–12 часов

**Нужно понять:** provider/resource/data source; HCL; variable/local/output; dependency graph; `init/fmt/validate/plan/apply/destroy`; state; drift; sensitive values.

**Практический результат:** Terraform создаёт ограниченный набор облачных ресурсов без ручного повторения в UI.

**Инкремент WatchOps:** описать сеть, VM и firewall/security rules окружения.

**Босс:** создать инфраструктуру по схеме, прочитать plan и изменить ресурс без случайного разрушения зависимостей.

**GitHub-артефакт:** `terraform/` с README, variables example и безопасным plan summary.

**Definition of Done:** ты читаешь plan до apply и понимаешь, почему state нельзя коммитить или терять.

## Тема 36. Terraform state, modules, backend и import

**Ориентир:** 8–12 часов

**Нужно понять:** remote state и locking; module inputs/outputs; разделение environments; import; moved blocks на базовом уровне; lifecycle/prevent_destroy; drift detection.

**Практический результат:** инфраструктура разделена на modules, state хранится удалённо и защищён от параллельной записи.

**Инкремент WatchOps:** модуль staging и отдельные environment values.

**Босс:** импортировать вручную созданный ресурс, устранить drift и выполнить рефакторинг без пересоздания.

**GitHub-артефакт:** modules, backend documentation и drift incident.

**Definition of Done:** изменение структуры кода не разрушает работающий ресурс из-за смены адреса в state.

## Тема 37. Облако: сети, compute, storage и IAM

**Ориентир:** 7–10 часов

**Нужно понять:** region/AZ; VPC/VNet; subnet; route table; internet gateway; security group; compute/image; block/object storage; load balancer; managed DB; IAM role/service account; billing/tags.

**Практический результат:** спроектировано минимальное облачное окружение WatchOps с ограниченными правами и понятной стоимостью.

**Инкремент WatchOps:** выбрать одного cloud provider и сопоставить его сервисы с общими концепциями.

**Босс:** найти избыточно открытый доступ, неверный route, лишние IAM-права и ресурс без cost control.

**GitHub-артефакт:** `docs/cloud-architecture.md`, diagram, threat и cost notes.

**Definition of Done:** ты объясняешь архитектуру без привязки к кнопкам панели и не выдаёшь приложению admin.

## Тема 38. Босс IaC: восстановление окружения с нуля

**Ориентир:** 10–16 часов

**Нужно понять:** интеграцию Terraform, Ansible, registry и CD; bootstrap boundary; dependency ordering; destroy/recreate; disaster rehearsal.

**Практический результат:** новое окружение создаётся Terraform, настраивается Ansible и получает WatchOps через deployment pipeline.

**Инкремент WatchOps:** версия `v0.4.0` — полностью воспроизводимое VM/cloud-развёртывание.

**Босс:** удалить учебное окружение и восстановить его только из Git, secret storage и backup данных.

**GitHub-артефакт:** tag `v0.4.0`, architecture diagram, bootstrap guide и recovery evidence.

**Definition of Done:** ручные действия сведены к минимальному bootstrap, фактическое время восстановления измерено.

---
# Фаза VI. Kubernetes, Helm и GitOps

**Темы:** 39–49  
**Цель:** перенести WatchOps в Kubernetes и управлять релизами декларативно.

## Тема 39. Архитектура Kubernetes и declarative API

**Ориентир:** 6–9 часов

**Нужно понять:** cluster/control plane/node; API server, etcd, scheduler, controller manager, kubelet; object/spec/status; reconciliation; namespace; labels/annotations/selectors; `kubectl` и context; kind/k3d/k3s.

**Практический результат:** создан локальный cluster, исследованы системные компоненты и жизненный цикл простого объекта.

**Инкремент WatchOps:** namespace и соглашения labels для будущего deployment.

**Босс:** по состоянию объектов определить, какой controller восстановит удалённый Pod и почему.

**GitHub-артефакт:** `kubernetes/39-basics/` с manifests и схемой control loop.

**Definition of Done:** ты воспринимаешь YAML как запрос к API, а не как магический config запуска контейнера.

## Тема 40. Pod, Deployment, Job и CronJob

**Ориентир:** 6–9 часов

**Нужно понять:** Pod lifecycle; ReplicaSet/Deployment; rolling update; Job/CronJob; command/args/environment; restart policy; events/logs.

**Практический результат:** WatchOps API развёрнут Deployment-ом, периодическая проверка выполняется Job/CronJob.

**Инкремент WatchOps:** первая Kubernetes-версия без внешнего входа.

**Босс:** выбрать подходящий workload для трёх процессов и исправить CrashLoopBackOff.

**GitHub-артефакт:** workload manifests и explanation of choices.

**Definition of Done:** ты не редактируешь созданный controller-ом Pod как постоянное решение.

## Тема 41. Probes, requests/limits и безопасный rollout

**Ориентир:** 6–9 часов

**Нужно понять:** liveness/readiness/startup probes; CPU/memory requests/limits; QoS базово; OOMKilled и throttling; rollingUpdate; termination grace; PodDisruptionBudget базово.

**Практический результат:** WatchOps обновляется без направления трафика в неготовый Pod и имеет обоснованные ресурсы.

**Инкремент WatchOps:** подключить health endpoints и graceful shutdown.

**Босс:** исправить rollout, который формально завершился, но создаёт ошибки пользователям.

**GitHub-артефакт:** Deployment с probes/resources и отчёт теста rollout.

**Definition of Done:** probes проверяют правильные свойства, а limits не выбраны случайно.

## Тема 42. Service, DNS и Ingress

**Ориентир:** 7–10 часов

**Нужно понять:** ClusterIP/NodePort/LoadBalancer; selector и EndpointSlice; CoreDNS; service discovery; Ingress resource/controller; host/path routing; TLS termination; диагностика connectivity.

**Практический результат:** WatchOps доступен по имени через Ingress, PostgreSQL остаётся внутренним.

**Инкремент WatchOps:** service topology для API и БД.

**Босс:** найти несовпадающий selector, неверный targetPort, DNS-проблему и отсутствующий ingress controller.

**GitHub-артефакт:** Service/Ingress manifests, схема и network runbook.

**Definition of Done:** ты проверяешь endpoints отдельно от Service и знаешь место завершения TLS.

## Тема 43. ConfigMap, Secret и конфигурация окружений

**Ориентир:** 5–7 часов

**Нужно понять:** ConfigMap/Secret; envFrom против mounted file; base64 не encryption; config reload/restart; immutable config базово; external secret managers по назначению.

**Практический результат:** конфигурация WatchOps отделена от image/manifests, реальные секреты отсутствуют в Git.

**Инкремент WatchOps:** безопасная передача database URL и прочих настроек.

**Босс:** организовать dev/staging values и ротацию секрета без ручного редактирования Pod.

**GitHub-артефакт:** templates, secret-handling guide и `.gitignore`.

**Definition of Done:** в текущем дереве и новых commits нет реального секрета.

## Тема 44. PersistentVolume, PVC и stateful workloads

**Ориентир:** 7–10 часов

**Нужно понять:** PV/PVC/StorageClass; access modes; reclaim policy; dynamic provisioning; StatefulSet и stable identity; backup вне volume; managed DB против DB in-cluster.

**Практический результат:** состояние тестовой БД сохраняется после пересоздания Pod и восстанавливается из backup.

**Инкремент WatchOps:** локально PostgreSQL в StatefulSet; для production-подобной архитектуры оценить managed DB.

**Босс:** исправить Pending PVC, неверный mount и ложное предположение, что volume является backup.

**GitHub-артефакт:** storage manifests, decision record и recovery test.

**Definition of Done:** ты различаешь persistent storage, snapshot и проверенный backup.

## Тема 45. Kubernetes security: ServiceAccount, RBAC и NetworkPolicy

**Ориентир:** 7–10 часов

**Нужно понять:** ServiceAccount; Role/ClusterRole и bindings; least privilege; securityContext; runAsNonRoot; capabilities; read-only root filesystem базово; NetworkPolicy ingress/egress; namespace isolation.

**Практический результат:** WatchOps работает с минимальными Linux- и Kubernetes-привилегиями, связи ограничены необходимыми.

**Инкремент WatchOps:** разрешить API обращаться только к БД и необходимым внешним целям.

**Босс:** уменьшить чрезмерные права без остановки приложения и найти связь, заблокированную policy.

**GitHub-артефакт:** RBAC, securityContext, policies и threat notes.

**Definition of Done:** приложение не использует избыточный default ServiceAccount и не запускается privileged.

## Тема 46. Helm: упаковка и параметры релиза

**Ориентир:** 7–10 часов

**Нужно понять:** chart/template/values/release; helpers; functions/pipelines; dependencies; upgrade/rollback; `helm template`, lint и diff базово; environment values.

**Практический результат:** WatchOps упакован в собственный chart и разворачивается разными values без копирования manifests.

**Инкремент WatchOps:** chart версии v0.5.

**Босс:** спроектировать понятный values API, не превращая chart в универсальный язык программирования.

**GitHub-артефакт:** `helm/watchops/`, lint/tests и release notes.

**Definition of Done:** сгенерированные manifests проверяются до apply, secrets не зашиты в values.

## Тема 47. Kubernetes troubleshooting

**Ориентир:** 8–12 часов

**Нужно понять:** describe/events/logs/previous logs; Pending, ImagePullBackOff, CrashLoopBackOff, OOMKilled; DNS/Service/Endpoints; probes/rollout; node pressure/scheduling; debug container базово.

**Практический результат:** восстановлен релиз с неисправностями workload, network, config и storage.

**Инкремент WatchOps:** эксплуатационный экзамен Kubernetes-версии.

**Босс:** исправить минимум семь скрытых проблем без удаления всего namespace.

**GitHub-артефакт:** `incidents/kubernetes-01/` с evidence и prevention actions.

**Definition of Done:** для каждого симптома ты проверяешь status, events и ответственный controller, а не применяешь случайный YAML.

## Тема 48. GitOps и Argo CD

**Ориентир:** 7–10 часов

**Нужно понять:** Git как desired state; reconciliation/drift; Application, sync и health; manual/auto sync; app repo против environment repo; rollback через Git; secret strategies.

**Практический результат:** изменение версии в environment repository автоматически приводит cluster к нужному состоянию.

**Инкремент WatchOps:** environment directory/repository и Argo CD Application.

**Босс:** восстановить drift, провести promotion staging→production-like и откатиться через Git.

**GitHub-артефакт:** GitOps manifests, documented flow и история promotion.

**Definition of Done:** ручное изменение cluster не считается постоянным fix; desired state восстанавливается из Git.

## Тема 49. Босс Kubernetes: полный релиз WatchOps

**Ориентир:** 10–16 часов

**Нужно понять:** интеграцию Helm, GitOps, networking, storage, security и rollout; release acceptance criteria.

**Практический результат:** WatchOps `v0.5.0` полностью развёрнут в Kubernetes, обновляется и откатывается через GitOps.

**Инкремент WatchOps:** готовая Kubernetes-платформа до observability.

**Босс:** с чистого cluster выполнить install, safe upgrade, намеренную поломку readiness, диагностику и rollback.

**GitHub-артефакт:** tag `v0.5.0`, architecture diagram, operations guide и demo scenario.

**Definition of Done:** ни один обязательный ресурс не создаётся вручную без сохранения desired state в Git.

---
# Фаза VII. Observability, SRE, безопасность и инциденты

**Темы:** 50–58  
**Цель:** научиться наблюдать, защищать, восстанавливать и эксплуатировать систему.

## Тема 50. Метрики и Prometheus

**Ориентир:** 7–10 часов

**Нужно понять:** time series; metric name/labels; counter/gauge/histogram; cardinality; exporter/scrape; PromQL basics; RED и USE; service discovery.

**Практический результат:** Prometheus собирает инфраструктурные и прикладные метрики WatchOps.

**Инкремент WatchOps:** request count, errors, latency и результаты проверок целей.

**Босс:** спроектировать метрики без взрыва cardinality и ответить PromQL-запросами на эксплуатационные вопросы.

**GitHub-артефакт:** metrics endpoint, scrape config/ServiceMonitor и PromQL examples.

**Definition of Done:** ты отличаешь событие для лога от агрегируемой метрики и не используешь безграничный label.

## Тема 51. Grafana, alerting и Alertmanager

**Ориентир:** 7–10 часов

**Нужно понять:** dashboard как ответ на вопрос; alerting rule; pending/firing; routing/grouping/inhibition; symptom-based alerts; runbook link; alert fatigue.

**Практический результат:** созданы рабочие dashboards и actionable alerts с runbooks.

**Инкремент WatchOps:** панель availability, latency, error rate, saturation и зависимостей.

**Босс:** убрать шумные алерты и создать сигнал, обнаруживающий пользовательскую проблему до жалобы.

**GitHub-артефакт:** dashboards as code, alert rules и runbooks.

**Definition of Done:** у каждого alert есть смысл, порог, действие и проверка восстановления.

## Тема 52. Структурированные логи и Loki

**Ориентир:** 6–9 часов

**Нужно понять:** structured logging; timestamp/level/service/correlation ID; stdout в контейнерах; collection pipeline; Loki labels против fields; LogQL; retention; PII/secrets.

**Практический результат:** логи WatchOps централизованно собираются и связываются с запросом или проверкой.

**Инкремент WatchOps:** request/check correlation ID и переход от метрики к логам.

**Босс:** найти ошибку среди нескольких replicas без grep каждого Pod и устранить утечку секрета.

**GitHub-артефакт:** logging config, Loki/collector manifests и LogQL cookbook.

**Definition of Done:** логи пригодны для расследования и не содержат пароли, tokens и чувствительные payloads.

## Тема 53. Трассировка и OpenTelemetry

**Ориентир:** 6–9 часов

**Нужно понять:** trace/span; context propagation; instrumentation; collector; sampling; связь traces/metrics/logs; когда tracing полезнее логов.

**Практический результат:** пользовательский запрос прослеживается через API, внешнюю проверку и обращение к БД.

**Инкремент WatchOps:** базовая OpenTelemetry-инструментация.

**Босс:** найти участок задержки по trace и доказать, что проблема не в Nginx или сети.

**GitHub-артефакт:** OTel config и diagnostic case.

**Definition of Done:** ты понимаешь стоимость tracing и не включаешь 100% sampling без оценки.

## Тема 54. SLI, SLO, SLA и error budget

**Ориентир:** 6–8 часов

**Нужно понять:** availability/latency/correctness/freshness; SLI/SLO/SLA; error budget; burn rate; user journey; toil; reliability trade-off.

**Практический результат:** для WatchOps определены измеримые SLO и burn-rate alerts.

**Инкремент WatchOps:** формально определить, что значит «WatchOps работает» для пользователя.

**Босс:** выбрать SLI, который не остаётся зелёным при сломанном пользовательском сценарии.

**GitHub-артефакт:** `docs/slo.md`, PromQL rules и rationale.

**Definition of Done:** SLO измерим, имеет окно и цель и влияет на решения о релизах.

## Тема 55. Backup, restore и disaster recovery

**Ориентир:** 7–10 часов

**Нужно понять:** backup/snapshot/replica; RPO/RTO; retention/offsite; consistency; restore testing; disaster recovery plan.

**Практический результат:** автоматический backup WatchOps восстановлен в новое окружение за измеренное время.

**Инкремент WatchOps:** backup PostgreSQL и критичной конфигурации; recovery game day.

**Босс:** удалить данные и восстановить до заданных RPO/RTO, обнаружив одну повреждённую копию.

**GitHub-артефакт:** backup automation, restore runbook, evidence и фактические RPO/RTO.

**Definition of Done:** успешный backup job не считается доказательством без restore test.

## Тема 56. DevSecOps и supply-chain безопасность

**Ориентир:** 8–12 часов

**Нужно понять:** threat model; least privilege; dependency/SAST/secret/image/IaC scanning; SBOM; подпись/provenance базово; patching; TLS/secret rotation; Kubernetes hardening; risk acceptance.

**Практический результат:** pipeline и runtime имеют разумные security gates без бессмысленного блокирования разработки.

**Инкремент WatchOps:** Trivy или аналоги, secret scanning, dependency updates и security checklist.

**Босс:** разобрать findings, отделить exploitable risk от шума и безопасно обновить зависимость.

**GitHub-артефакт:** security workflow, threat model, remediation report и policy.

**Definition of Done:** findings не игнорируются и не блокируются вслепую; решение обосновано риском и контекстом.

## Тема 57. Incident response, postmortem и capacity

**Ориентир:** 8–12 часов

**Нужно понять:** severity/impact; incident commander; коммуникация; mitigation против root cause fix; timeline; blameless postmortem; corrective actions; capacity; timeouts/retries/backoff.

**Практический результат:** проведён полный учебный incident: detection, localization, mitigation, recovery и postmortem.

**Инкремент WatchOps:** сценарий роста latency, исчерпания connection pool, лавины retries и перегрузки БД.

**Босс:** работать только по симптомам и ограниченному времени; сначала восстановить сервис, затем искать root cause.

**GitHub-артефакт:** `incidents/final-incident/` с timeline, impact, root cause, actions и follow-up commits.

**Definition of Done:** postmortem содержит системные улучшения с владельцами и критериями, а не обвинение человека.

## Тема 58. Финальный босс: WatchOps Production Platform

**Ориентир:** 20–30 часов, несколько сессий

**Нужно понять:** интеграцию Linux, сетей, Git, приложения, БД, Docker, CI/CD, IaC, Kubernetes, observability, security и SRE; архитектурные компромиссы; защиту проекта.

**Практический результат:** из Git и защищённого secret storage можно восстановить production-подобную платформу WatchOps, выпустить релиз, наблюдать её и пережить инцидент.

**Инкремент WatchOps:** финальная версия `v1.0.0`.

**Босс:** clean environment → provisioning → deployment → smoke test → load/incident → alert → mitigation → rollback/restore → postmortem. Готовых команд нет.

**GitHub-артефакт:** tag `v1.0.0`, главный README, ADR, diagrams, runbooks, dashboards, demo script/video и portfolio page.

**Definition of Done:** ты 30–45 минут защищаешь архитектуру, показываешь live demo, диагностируешь новую поломку и честно объясняешь ограничения.

---

# После roadmap

## Подготовка к собеседованиям

Начиная с темы 24:

- раз в неделю объяснять одну законченную часть проекта без заметок;
- решать 5–10 вопросов по пройденным темам;
- разбирать одну новую поломку;
- улучшать README и архитектурную схему;
- после темы 29–33 регулярно откликаться, не дожидаясь Kubernetes.

## Что сознательно отложено

До завершения основной программы не уходить глубоко в несколько облаков, Jenkins internals, OpenShift, service mesh, Kafka internals, operators, Crossplane, Pulumi, Packer, eBPF, multi-cluster и сертификаты. Эти направления добавляются под вакансии или реальные задачи после появления основной связки:

`Linux → сети → приложение → контейнер → CI/CD → IaC → Kubernetes → observability → incidents`.

## Главный критерий прогресса

Не «я видел эту технологию», а:

> Я построил. Я могу объяснить. Я сломал. Я локализовал причину. Я восстановил. Вот код, конфигурация и история решений.
