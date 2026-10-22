import 'dart:math';

// Завдання 4. Імітація сервісу; мережеві запити не виконуються.
class WeatherService {
  WeatherService({Random? random}) : _random = random ?? Random();

  final Random _random;

  int _nextTemperature() => _random.nextInt(46) - 10; // -10..35 °C

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final normalizedCity = city.trim();
    if (normalizedCity.isEmpty) {
      throw ArgumentError('Місто не вказано');
    }
    await Future<void>.delayed(const Duration(seconds: 1));
    const conditions = ['Сонячно', 'Хмарно', 'Дощ'];
    return {
      'city': normalizedCity,
      'temp': _nextTemperature(),
      'condition': conditions[_random.nextInt(conditions.length)],
    };
  }

  Stream<int> temperatureUpdates({int times = 5}) async* {
    if (times < 0) {
      throw RangeError.range(times, 0, null, 'times');
    }
    // times == 0: потік завершується без значень і без затримки.
    for (var i = 0; i < times; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield _nextTemperature();
    }
  }
}
