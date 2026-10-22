import 'dart:math';
import 'package:test/test.dart';
import 'package:module_control_1/library.dart';
import 'package:module_control_1/weather_service.dart';

void main() {
  const book = Book(title: 'Dart у дії', year: 2022, author: 'І. Петренко');
  const magazine = Magazine(title: 'Mobile Dev', year: 2023, issueNumber: 5);

  test('Порожня бібліотека та відсутній рік', () {
    final library = Library();
    expect(library.findOldest(), isNull);
    expect(library.allDescriptions, isEmpty);
    expect(library.findByYear(2022), isEmpty);
  });
  test('Точні описи обох підкласів', () {
    expect(book.describe(), 'Dart у дії (2022) — І. Петренко');
    expect(magazine.describe(), 'Mobile Dev (2023), випуск 5');
  });
  test('Фільтрація повертає всі збіги; описи зберігають порядок', () {
    final library = Library()
      ..addItem(magazine)
      ..addItem(book)
      ..addItem(book);
    expect(library.findByYear(2022), [book, book]);
    expect(library.allDescriptions,
        [magazine.describe(), book.describe(), book.describe()]);
    final result = library.findByYear(2022)..clear();
    expect(result, isEmpty);
    expect(library.findByYear(2022), hasLength(2));
  });
  test('Найстаріший, один елемент та однакові роки', () {
    final library = Library()..addItem(magazine);
    expect(library.findOldest(), same(magazine));
    library.addItem(book);
    library.addItem(const Magazine(title: 'Інший', year: 2022, issueNumber: 1));
    expect(library.findOldest(), same(book));
  });

  test('Порожнє місто і пробіли дають ArgumentError', () async {
    final service = WeatherService();
    for (final city in ['', '   ']) {
      await expectLater(
          service.fetchCurrentWeather(city),
          throwsA(isA<ArgumentError>()
              .having((e) => e.message, 'message', 'Місто не вказано')));
    }
  });
  test('Погода: затримка, структура, типи та нормалізація', () async {
    final timer = Stopwatch()..start();
    final weather = await WeatherService(random: Random(42))
        .fetchCurrentWeather('  Київ  ');
    expect(timer.elapsedMilliseconds, greaterThanOrEqualTo(950));
    expect(weather.keys.toSet(), {'city', 'temp', 'condition'});
    expect(weather['city'], 'Київ');
    expect(weather['temp'], inInclusiveRange(-10, 35));
    expect(weather['condition'], isIn(['Сонячно', 'Хмарно', 'Дощ']));
  });
  test('Потік видає рівно 3 значення з інтервалом і завершується', () async {
    final timer = Stopwatch()..start();
    var previousMs = 0;
    final values = <int>[];
    await for (final temp
        in WeatherService(random: Random(7)).temperatureUpdates(times: 3)) {
      final now = timer.elapsedMilliseconds;
      expect(now - previousMs, greaterThanOrEqualTo(950));
      previousMs = now;
      expect(temp, inInclusiveRange(-10, 35));
      values.add(temp);
    }
    expect(values, hasLength(3));
  });
  test('Нульовий та від’ємний times', () async {
    final service = WeatherService();
    expect(await service.temperatureUpdates(times: 0).toList(), isEmpty);
    await expectLater(service.temperatureUpdates(times: -1).toList(),
        throwsA(isA<RangeError>()));
  });
  test('За замовчуванням потік має 5 значень', () async {
    final values = await WeatherService().temperatureUpdates().toList();
    expect(values, hasLength(5));
  });
}
