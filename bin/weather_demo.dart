import 'package:module_control_1/weather_service.dart';

Future<void> main() async {
  final service = WeatherService();
  try {
    final weather = await service.fetchCurrentWeather('Київ');
    print(weather);
  } catch (error) {
    print('Помилка: $error');
  }

  // Окремо демонструємо обробку некоректного міста.
  try {
    await service.fetchCurrentWeather('   ');
  } on ArgumentError catch (error) {
    print('Очікувана помилка: ${error.message}');
  }

  try {
    await for (final temp in service.temperatureUpdates(times: 3)) {
      print('Температура: $temp°C');
    }
    print('Потік завершено: отримано 3 значення.');
  } catch (error) {
    print('Помилка потоку: $error');
  }
}
