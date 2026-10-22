# Модульний контроль 1: Вступ до мобільної розробки

**Рукасов Владислав • група Ік-42**  
Дисципліна: Програмування для мобільних платформ.

## Структура

- `lib/library.dart`, `bin/library_demo.dart` — завдання 1: класи та колекції.
- `lib/rating_badge.dart` — завдання 2: StatelessWidget.
- `lib/main.dart` — завдання 3: два екрани, setState, Navigator.
- `lib/weather_service.dart`, `bin/weather_demo.dart` — завдання 4: Future і Stream.
- `test/core_test.dart` — перевірки бібліотеки й асинхронного сервісу.
- `test/practical_test.dart` — перевірки віджетів і навігації.
- `DEMO_SCRIPT.md` — план власного запису екрана на 5–10 хвилин.

## Запуск

Потрібен встановлений Flutter із Dart SDK. Перевірене середовище: Flutter 3.47.4 / Dart 3.13.3.
Залежності зафіксовано у `pubspec.lock`.

```sh
flutter pub get
dart run bin/library_demo.dart
dart run bin/weather_demo.dart
flutter run -d chrome
```

У браузері показано три приклади RatingBadge й лічильник. Натисніть «+1» тричі,
потім «Детальніше»: буде значення 3. Натисніть «Назад»: на головному екрані
залишиться 3. Збільште ще раз і повторіть перехід: буде 4.

Вебплатформа дозволяє легко показати Flutter UI без налаштування емулятора.
Для мобільного запуску можна згенерувати платформні каталоги:

```sh
flutter create --platforms=android,ios .
flutter run
```

Збірка iOS потребує macOS, Xcode і налаштованих інструментів розробника.

## Перевірка

```sh
dart format --output=none --set-exit-if-changed lib bin test
flutter analyze
dart test test/core_test.dart --reporter expanded
flutter test --reporter expanded
# Альтернативно для перевірок у браузері:
flutter test --platform chrome --reporter expanded
flutter build web
```

## Важливі рішення

1. `findOldest()` повертає `null` для порожньої бібліотеки; за однакового року —
   перший доданий елемент. Пошук O(n), додаткова пам’ять O(1).
2. `findByYear` та `allDescriptions` повертають нові списки.
3. Колір RatingBadge визначає початкове значення рейтингу, а округлення стосується
   лише тексту: наприклад, 3.99 показується як 4.0, але колір залишається оранжевим.
4. Рейтинг поза 0–5, NaN або нескінченність відхиляються. Є assert для debug
   і перевірка RangeError у build для release. Конструктор залишається const.
5. DetailScreen одержує знімок int через конструктор. HomeScreen лишається
   в стеку Navigator, тому його State зберігається.
6. Сервіс погоди — симуляція. Температура випадкова в діапазоні -10..35 °C;
   місто очищується від крайніх пробілів; порожнє місто дає ArgumentError.
7. `times == 0` одразу завершує потік; `times < 0` дає RangeError як помилку потоку.
   Два випадкові значення можуть збігтися — це нормальна поведінка генератора.

## Публікація та здача

Цей каталог готовий для GitHub-репозиторію. Створіть репозиторій у своєму акаунті
та завантажте файли (без build, .dart_tool та .idea). Додайте фактичне посилання
до здачі. Відео потрібно записати особисто за DEMO_SCRIPT.md.
GitHub-репозиторій і відеозапис не створені автоматично; наявність README
або сценарію не замінює ці дві вимоги.

## Джерела

- https://docs.flutter.dev/perf/impeller
- https://docs.flutter.dev/perf/impeller#android
- https://docs.flutter.dev/data-and-backend/state-mgmt/simple
- https://api.flutter.dev/flutter/widgets/State/setState.html
- https://dart.dev/libraries/async/async-await
- https://dart.dev/language/async