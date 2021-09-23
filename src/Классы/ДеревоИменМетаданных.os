#Использовать fs
#Использовать logos

#Область ОписаниеПеременных

Перем Лог;

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Подготовить значение для выгрузки в json
//
// Параметры:
//   Поддержка - Поддержка - объект-информатор по данным поддержки
//   КаталогИсходников - Строка - Абсолютный путь к каталогу исходников конфигурации
//   ФайлыИзменяемые - Массив - массив относительных путей метаданных
//
//  Возвращаемое значение:
//   Произвольный - результат трансформации, которое нужно выгрузить в json
//
Функция ПодготовитьЗначениеДляВыгрузки(Знач Поддержка, Знач КаталогИсходников, Знач ФайлыИзменяемые) Экспорт

	Результат = Новый Структура;
	МетаданныеКаталоги = УтилитыПоддержки.МетаданныеКаталоги();

	ВременнаяКоллекция = Новый Структура;

	Для каждого ПутьФайла Из ФайлыИзменяемые Цикл
		ОтносительныйПуть = ФС.ОтносительныйПуть(КаталогИсходников, ПутьФайла);
		Лог.Отладка("ОтносительныйПуть " + ОтносительныйПуть);
		Сегменты = СтрРазделить(ОтносительныйПуть, ПолучитьРазделительПути());

		ВидМетаданного = МетаданныеКаталоги.Получить(Сегменты[0]);
		Если ВидМетаданного = Неопределено Тогда
			// неизвестный тип
			Продолжить;
		КонецЕсли;
		ИмяМетаданного = Сегменты[1];

		УтилитыПоддержки.ДобавитьВложенныйЕслиЕщеНет(ВременнаяКоллекция, ВидМетаданного, ИмяМетаданного, Новый Структура);

	КонецЦикла;

	Для каждого КлючЗначение Из ВременнаяКоллекция Цикл

		Коллекция = Новый Массив;
		УтилитыПоддержки.СкопироватьЭлементы(КлючЗначение.Значение, Коллекция);

		Результат.Вставить(КлючЗначение.Ключ, Коллекция);
	КонецЦикла;

	Возврат Результат;


КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПриСозданииОбъекта(Знач ПарамЛог)
	Лог = ПарамЛог;
КонецПроцедуры

#КонецОбласти
