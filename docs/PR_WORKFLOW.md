# PR workflow (коротко)

Этот чеклист нужен, чтобы быстро и без конфликтов обновлять ветку и PR.

## 1) Синхронизировать ветку с main

```bash
git checkout work
git fetch origin
git rebase origin/main
```

Если во время `rebase` есть конфликт:

1. Исправь конфликтные файлы (удали маркеры `<<<<<<<`, `=======`, `>>>>>>>`).
2. Продолжи:

```bash
git add .
git rebase --continue
```

Проверка, что маркеров не осталось:

```bash
rg -n "^(<<<<<<<|=======|>>>>>>>)" README.md docs mobile_flutter || true
```

## 2) Проверить рабочее дерево

```bash
git status --short
```

## 3) Закоммитить и отправить изменения

```bash
git add .
git commit -m "docs: add PR workflow checklist"
git push -u origin work
```

## 4) Обновить текущий PR

Если PR уже открыт из `work` в `main`, новый создавать не нужно: достаточно `git push` в ту же ветку.

## 5) Когда нужен новый PR

Новый PR создаётся только когда изменения идут из **новой ветки** (например, `feature/voice-recording`) или когда старый PR уже закрыт.
