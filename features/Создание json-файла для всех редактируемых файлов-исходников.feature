# language: ru

Функциональность: Создание json-файла для файлов-исходников на базе файла поставки Ext/ParentConfigurations.bin

Как разработчик
Я хочу быстро получить генерить json-файлы различного формата для всех файлов поддержки
Чтобы я мог быстро и автоматически подключать эти файлы к другим инструментам

Контекст: Отключение отладки в логах
    Дано Я выключаю отладку лога с именем "oscript.lib.commands"
    # Дано Я выключаю отладку лога с именем "oscript.app.vanessa-support"
    # Дано Я включаю отладку лога с именем "oscript.app.vanessa-support"
    И Я очищаю параметры команды "oscript" в контексте
# И я включаю полную отладку логов пакетов OneScript

    И Я сохраняю каталог проекта в контекст

Сценарий: Генерация json-файла для всех редактируемых файлов-исходников

    # И Я сохраняю значение "DEBUG" в переменную окружения "LOGOS_LEVEL"
    Дано Я создаю временный каталог и сохраняю его в контекст
    Дано я устанавливаю временный каталог как рабочий каталог
    И Я установил рабочий каталог как текущий каталог
    # Дано я подготовил репозиторий и рабочий каталог проекта

    Когда Я добавляю параметр "<КаталогПроекта>/src/main.os" для команды "oscript"
    И Я добавляю параметр "json" для команды "oscript"
    И Я добавляю параметр "--format ДеревоИменМетаданных" для команды "oscript"
    И Я добавляю параметр "--src <КаталогПроекта>/fixtures/simple-config" для команды "oscript"
    И Я добавляю параметры для команды "oscript"
    # | <КаталогПроекта>/src/main.os |
    # | json |
    # | --src КаталогПроекта\fixtures |
    | result.json |
    И Я выполняю команду "oscript"
    И Я показываю вывод команды

    # Тогда Вывод команды "oscript" содержит
    #     | ИНФОРМАЦИЯ - Выполняю команду/действие в режиме 1С:Предприятие |
    # Тогда Вывод команды "oscript" не содержит
    #     | Ошибка: Неудача при выполнении основного кода |
    И код возврата команды "oscript" равен 0
    И файл "result.json" существует
    И файл "result.json" содержит
        """
            "Справочники": [
               "ПервыйСправочник"
            ]
        """
    И файл "result.json" содержит
        """
            "Документы": [
                "ПервыйДокумент"
            ]
        """
