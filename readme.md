# Vanessa-support

[![Тестирование](https://github.com/vanessa-opensource/vanessa-support/actions/workflows/testing.yml/badge.svg)](https://github.com/vanessa-opensource/vanessa-support/actions/workflows/testing.yml)
[![GitHub release](https://img.shields.io/github/release/vanessa-opensource/vanessa-support.svg)](https://github.com/vanessa-opensource/vanessa-support/releases)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/vanessa-opensource/vanessa-support/%D0%A2%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5?style=flat-square)](https://github.com/vanessa-opensource/vanessa-support/actions)
[![Статус Порога Качества](https://sonar.openbsl.ru/api/project_badges/measure?project=vanessa-support&metric=alert_status)](https://sonar.openbsl.ru/dashboard?id=vanessa-support)
[![Покрытие](https://sonar.openbsl.ru/api/project_badges/measure?project=vanessa-support&metric=coverage)](https://sonar.openbsl.ru/dashboard?id=vanessa-support)
<!-- [![Технический долг](https://sonar.openbsl.ru/api/project_badges/measure?project=vanessa-support&metric=sqale_index)](https://sonar.openbsl.ru/dashboard?id=vanessa-support) -->
[![Строки кода](https://sonar.openbsl.ru/api/project_badges/measure?project=vanessa-support&metric=ncloc)](https://sonar.openbsl.ru/dashboard?id=vanessa-support)

Приложение командной строки для генерации различных файлов на основании информации о поддержке метаданных в исходниках 1С-конфигурации в форматах Конфигуратор или EDT.

>[Vanessa open-source![Chat on Telegram vanessa_opensource_chat](https://img.shields.io/badge/Chat%20on-Telegram-brightgreen.svg)](https://t.me/vanessa_opensource_chat) или [oscript_library ![Chat on Telegram oscript_library](https://img.shields.io/badge/Chat%20on-Telegram-brightgreen.svg)](https://t.me/oscript_library) - в этих чатах вы можете задавать любые вопросы разработчикам и активным участникам.

## Возможности

Приложение умеет создавать json-файлы с группировкой по метаданными.

Подобные файлы могут быть использованы для различные целей.
Например, для дымового тестирования через Vanessa-ADD или для контроля исходников на внутренние стандарты вашей компании.

### Создание json-файлов - команда json

Например, команда `vanessa-support json --src fixtures\simple-config result.json` выдаст готовый json-файл для всех метаданных, которые могут быть изменены и не находятся в режиме чтения.

Будет сформирован следующий файл
```json
{
    "Справочники": [
        "ПервыйСправочник"
    ],
    "Документы": [
        "ПервыйДокумент"
    ]
}
```
