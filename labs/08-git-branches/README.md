# Тема 08 — Ветки, merge, конфликты и GitHub

## Цель

Освоить рабочий Git-flow с отдельными ветками, объединением изменений, разрешением конфликтов, синхронизацией с удалённым репозиторием и Pull Request.

## Практический результат

В рамках темы были выполнены:

- создание и переключение между ветками через `git switch`;
- отдельные изменения в `main` и feature-ветках;
- fast-forward merge;
- merge commit;
- ручное разрешение merge conflict;
- работа с `origin`, `fetch`, `pull` и `push`;
- публикация feature-ветки на GitHub;
- Pull Request из feature-ветки в `main`;
- merge Pull Request через GitHub;
- синхронизация локального `main` после удалённого merge;
- самостоятельный конфликтующий сценарий;
- отмена плохого commit через `git revert`.

## Связь с WatchOps

Начиная с этой темы изменения проекта должны выполняться в отдельных ветках вида:

```text
feature/...
fix/...
docs/...
```

Типичный рабочий процесс:

```text
main
     feature/something
          |
          v
       commit
          |
          v
        push
          |
          v
     Pull Request
          |
          v
        review
          |
          v
        merge
          |
          v
         main
```

## Ветки и HEAD

Ветка Git — это указатель на commit.

`HEAD` показывает текущее положение пользователя в истории Git и обычно указывает на текущую локальную ветку.

Пример:

```text
HEAD
 |
 v
feature/example
 |
 v
commit
```

`HEAD` не связан с `git push` и существует локально.

## Fast-forward merge

Fast-forward возможен, когда принимающая ветка не имеет собственных новых commit после точки ответвления.

До merge:

```text
A --- B        main
       \
        C      feature
```

После merge:

```text
A --- B --- C
            ^
            |
           main
```

Дополнительный merge commit при этом не создаётся.

## Merge commit

Если обе ветки независимо продвинулись после общего предка:

```text
        C --- D   feature
       /
A --- B
       \
        E         main
```

простого перемещения указателя уже недостаточно.

После merge создаётся отдельный commit объединения:

```text
        C --- D
       /       \
A --- B         M   main
       \       /
        E -----
```

У merge commit два родителя.

## Merge conflict

Конфликт возникает, когда Git не может автоматически определить правильный итог изменений.

В лаборатории обе ветки изменяли одну и ту же строку одного файла.

Git добавил конфликтные маркеры:

```text
<<<<<<< HEAD
версия текущей ветки
=======
версия присоединяемой ветки
>>>>>>> feature/example
```

Алгоритм разрешения:

1. изучить обе версии;
2. определить правильный итог;
3. удалить конфликтные маркеры;
4. проверить файл;
5. выполнить `git add`;
6. завершить merge commit.

`git add` после конфликта означает не только добавление файла в staging area, но и подтверждение того, что конфликт этого файла считается разрешённым.

## Remote

Удалённый репозиторий настроен как:

```text
origin
```

Основные команды:

### `git fetch`

Получает новую историю из удалённого репозитория и обновляет remote-tracking ветки, например:

```text
origin/main
```

При этом текущая локальная ветка и working tree не изменяются.

### `git pull`

Обычно выполняет:

```text
fetch + интеграция изменений
```

То есть после получения удалённых commit Git пытается добавить их в текущую локальную ветку.

Для безопасного обновления использовалось:

```bash
git pull --ff-only
```

Такой pull выполняется только тогда, когда локальную ветку можно просто передвинуть вперёд без дополнительного merge.

### `git push`

Отправляет локальные commits в удалённый репозиторий.

Пример публикации новой ветки:

```bash
git push -u origin feature/watchops-github-flow
```

Параметр `-u` (`--set-upstream`) связывает локальную ветку с соответствующей удалённой веткой.

## `main` и `origin/main`

Это разные указатели:

```text
main
```

— локальная ветка.

```text
origin/main
```

— локальное представление известного Git состояния удалённой ветки `main`.

После `git fetch` значение `origin/main` может измениться, даже если локальный `main` остаётся на прежнем commit.

## Pull Request

Был создан Pull Request:

```text
feature/watchops-github-flow -> main
```

В Pull Request:

- `base` — ветка, **в которую** предлагаются изменения;
- `head` / `compare` — ветка, **из которой** приходят изменения.

Для лаборатории:

```text
base:    main
head:    feature/watchops-github-flow
```

PR содержал один commit и один файл:

```text
labs/08-git-branches/pr-demo.txt
```

После проверки diff Pull Request был объединён в `main` через GitHub.

## Стратегии merge в GitHub

### Create a merge commit

Сохраняет отдельную историю feature-ветки и создаёт merge commit.

### Squash and merge

Объединяет все commits Pull Request в один новый commit.

Подходит, когда feature-ветка содержит много промежуточных или технических commit.

### Rebase and merge

Переносит commits feature-ветки поверх актуального `main`, создавая линейную историю.

Rebase переписывает commit history, поэтому его нужно использовать осознанно, особенно для уже опубликованных веток.

## Самостоятельный босс

Для босса был создан:

```text
labs/08-git-branches/boss-config.txt
```

Общее состояние:

```text
enabled=api
```

После этого ветки разошлись:

```text
feature/git-boss:
enabled=api,health

main:
enabled=api,metrics
```

Общий предок был проверен через:

```bash
git merge-base main feature/git-boss
```

После merge возник настоящий `content conflict`.

Финальный корректный результат:

```text
enabled=api,metrics,health
```

Конфликт был разрешён вручную, после чего создан merge commit:

```text
19e53fc lab: boss defeated
```

Позже результат был нормализован отдельным исправляющим commit:

```text
2652b41 fix: normalize boss config after conflict resolution
```

## Диагностическая поломка и revert

После успешного босса была намеренно внесена поломка:

```text
enabled=api
```

Плохой commit:

```text
68d64f8 lab: diagnostic trouble
```

Для его отмены использовался:

```bash
git revert 68d64f8
```

Git создал новый commit:

```text
60c9404 Revert "lab: diagnostic trouble"
```

Важно: `git revert` не удаляет плохой commit из истории.

История сохраняется:

```text
плохой commit
      |
      v
revert commit
```

Это безопасный способ отмены уже опубликованных изменений без переписывания общей истории.

## Что важно запомнить

- ветка — это указатель на commit;
- `HEAD` показывает текущее положение в Git;
- `git merge` выполняется не только на `main`;
- изменения вливаются **в текущую ветку**;
- fast-forward не создаёт merge commit;
- merge commit имеет двух родителей;
- конфликт разрешает человек, Git лишь отмечает место несовместимых изменений;
- `git fetch` получает изменения, но не изменяет текущий working tree;
- `git pull` получает и интегрирует изменения;
- `git push` отправляет локальную историю на remote;
- Pull Request — механизм GitHub поверх Git;
- `base` — куда вливаем, `head` — откуда;
- `git revert` отменяет изменение новым commit и не переписывает историю;
- `force push` нельзя использовать без осознанной необходимости.

## Definition of Done

В рамках темы выполнено:

- [x] изменение создано в отдельной feature-ветке;
- [x] выполнен fast-forward merge;
- [x] создан настоящий merge commit;
- [x] вручную разрешён merge conflict;
- [x] отработаны `fetch`, `pull` и `push`;
- [x] feature-ветка опубликована на GitHub;
- [x] создан и проверен Pull Request;
- [x] Pull Request объединён в `main`;
- [x] выполнен самостоятельный конфликтующий босс;
- [x] плохой commit отменён через `git revert`;
- [x] итоговый `boss-config.txt` содержит `enabled=api,metrics,health`;
- [x] working tree приведён в чистое состояние.

## Итог

Тема закрепила базовый командный Git-workflow:

```text
branch -> commit -> push -> Pull Request -> review -> merge -> fetch/pull
```

Также отработаны два критичных эксплуатационных навыка:

```text
merge conflict -> ручное разрешение
bad commit -> git revert
```
