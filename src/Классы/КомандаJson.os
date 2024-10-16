#Использовать fs
#Использовать logos
#Использовать v8metadata-reader

#Область ОписаниеПеременных

Перем Лог; // объект лога
Перем ИмяГенератора; // имя генератора формата
Перем КаталогИсходников; // каталог исходников
Перем Поддержка; // объект поддержки

#КонецОбласти

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОписаниеКоманды(Команда) Экспорт

	ПутьИсходников = Команда.Опция("s src", "", "Путь к исходникам в формате Конфигуратора или EDT")
    .ТСтрока()
    .ВОкружении(ПараметрыПриложения.Имя() + "src")
    .ПоУмолчанию("src");

	ИмяФормата = Команда.Опция("f format", "", "Имя класса-генератора данных")
    .ТСтрока()
	.Обязательный()
    .ВОкружении(ПараметрыПриложения.Имя() + "format")
    .ПоУмолчанию("");

	ВыходнойФайл = Команда.Аргумент("FILE", "", "Путь выходного файла в формате json")
		.ТСтрока() // тип опции Строка
		.ВОкружении(ПараметрыПриложения.Имя() + "FILE")
		.ПоУмолчанию("");

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт

	Лог = Логирование.ПолучитьЛог(ПараметрыПриложения.ИмяЛога());
	// Лог.УстановитьУровень(УровниЛога.Отладка);

	ИмяГенератора = Команда.ЗначениеОпции("format");
	КаталогИсходников = Команда.ЗначениеОпции("src");
	ФайлРезультат = Команда.ЗначениеАргумента("FILE");

	Лог.Отладка("ИмяГенератора %1", Команда.ЗначениеОпции("format"));
	Лог.Отладка("КаталогИсходников %1", Команда.ЗначениеОпции("src"));
	Лог.Отладка("ФайлРезультат %1", Команда.ЗначениеАргумента("FILE"));

	Если Не ФС.КаталогСуществует(КаталогИсходников) Тогда
		ВызватьИсключение "Не существует каталог исходников " + КаталогИсходников;
	КонецЕсли;

	Поддержка = Новый Поддержка(КаталогИсходников);

	ПоказатьИнформациюОПоддержке();

	ФайлыИзменяемые = Поддержка.ВсеФайлы(1, "+");
	Лог.Отладка("Файлы изменяемые %1", ФайлыИзменяемые.Количество());

	Для Счетчик = 0 По Мин(15, ФайлыИзменяемые.Количество() - 1)  Цикл

		ОтносительныйПуть = ФС.ОтносительныйПуть(КаталогИсходников, ФайлыИзменяемые[Счетчик]);
		Лог.Отладка(ОтносительныйПуть);

	КонецЦикла;

	ОбъектГенератор = ПодключитьГенератор(ИмяГенератора);

	ЗначениеДляВыгрузки = ОбъектГенератор.ПодготовитьЗначениеДляВыгрузки(Поддержка, КаталогИсходников, ФайлыИзменяемые);

	ЗаписатьФайлJSON(ЗначениеДляВыгрузки, ФайлРезультат);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПоказатьИнформациюОПоддержке()

	ФайлыНаЗамке = Поддержка.ВсеФайлы(0);
	Лог.Отладка("Файлов на замке %1", ФайлыНаЗамке.Количество());

	ФайлыНаПоддержке = Поддержка.ВсеФайлы(1);
	Лог.Отладка("Файлы на поддержке %1", ФайлыНаПоддержке.Количество());

	ФайлыСнятоСПоддержки = Поддержка.ВсеФайлы(2);
	Лог.Отладка("Файлы снято с поддержки %1", ФайлыСнятоСПоддержки.Количество());

	ФайлыНетПоддержки = Поддержка.ВсеФайлы(3);
	Лог.Отладка("Файлы нет поддержки %1", ФайлыНетПоддержки.Количество());

	ФайлыПрочие = Поддержка.ВсеФайлы(4);
	Лог.Отладка("Файлы прочие %1", ФайлыПрочие.Количество());

	ФайлыИзменяемые = Поддержка.ВсеФайлы(1, "+");
	Лог.Отладка("Файлы изменяемые %1", ФайлыИзменяемые.Количество());

КонецПроцедуры

Функция ПодключитьГенератор(Знач ИмяГенератора)

	Результат =  "";
	Выполнить(СтрШаблон("Результат = Новый %1(Лог);", ИмяГенератора));
	Возврат Результат;

КонецФункции

Процедура ЗаписатьФайлJSON(Знач Значение, Знач ФайлРезультат)

	Перем ПоказатьСтрокуДляОтладки;
	ПоказатьСтрокуДляОтладки = Ложь;

	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(, "  ");

	ЗаписьJSON = Новый ЗаписьJSON();
	Если ПоказатьСтрокуДляОтладки Тогда
		ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписи);
	Иначе
		ЗаписьJSON.ОткрытьФайл(ФайлРезультат, , , ПараметрыЗаписи);
	КонецЕсли;

	ЗаписатьJSON(ЗаписьJSON, Значение);

	Если ПоказатьСтрокуДляОтладки Тогда
		Лог.Отладка(ЗаписьJSON.Закрыть());
	Иначе
		ЗаписьJSON.Закрыть();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
