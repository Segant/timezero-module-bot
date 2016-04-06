# Бот для онлайн игры [Timezero](http://timezero.ru). #

Работает при помощи встроенных в игру модулей (кпк).
Написан на [ActionScript 1/2](http://ru.wikipedia.org/wiki/Action_Script).
К сожалению на данный момент **почти не работает** - у меня не было времени его тестировать и доделывать.

**Скорее всего я дописывать его не буду - при заходе на главную страницу ТЗ я в последнее время испытываю просто-таки отвращение. Поэтому готов отдать в хорошие, знающие AS1/2 руки.**

На данный момент проект состоит из :
  * [ASL](http://code.google.com/p/timezero-module-bot/source/browse/#svn/trunk/timezero-module-bot/asl) - Action script library. Много разных полезных фич имхо.
  * [WALL-E](http://code.google.com/p/timezero-module-bot/source/browse/#svn/trunk/timezero-module-bot/walle) - собственно говоря сам бот.
  * [Timezero library](http://code.google.com/p/timezero-module-bot/source/browse/#svn/trunk/timezero-module-bot/timezero).
  * [FLow](http://code.google.com/p/timezero-module-bot/source/browse/#svn/trunk/flow)(flash `[`dont know what`]`) - Специально написанная прога на [языке D](http://www.digitalmars.com/d/index.html) для patch'инга _tz.swf_.

Также используются :
  * [AsUnit](http://asunit.org/)
  * [AsCrypt](http://osflash.org/ascrypt)

### Текущий TODO : ###
  * Экспорт настроек.
  * Убрать мусор из printDebug.
  * Objective manager.
  * Починить диалоги с Сестрой дашкой.
  * Починить auto-battle на арене.
  * Unit-tests для ASL.
  * Привести в порядок FLOW.
  * **Документация!**
  * asl.logging **выполнено**
  * asl.testing **(?)**
  * Убрать зависимость asl от events таймзеры.

### Контактная информация : ###
  * ICQ    : 431935323
  * Jabber : edwinirving@jabber.ru