import 'package:module_control_1/library.dart';

void main() {
  final library = Library();
  print('Порожня бібліотека: ${library.findOldest()}');
  library.addItem(const Book(
    title: 'Dart у дії',
    year: 2022,
    author: 'І. Петренко',
  ));
  library.addItem(const Magazine(
    title: 'Mobile Dev',
    year: 2023,
    issueNumber: 5,
  ));
  for (final item in library.findByYear(2022)) {
    print('За 2022 рік: ${item.describe()}');
  }
  print('Усі описи: ${library.allDescriptions}');
  print('Найстаріший: ${library.findOldest()?.describe()}');
  print('За 1999 рік: ${library.findByYear(1999)}');
}
