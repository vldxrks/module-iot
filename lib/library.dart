// Завдання 1. Поліморфізм і робота з колекцією.
abstract class LibraryItem {
  const LibraryItem({required this.title, required this.year});

  final String title;
  final int year;

  String describe();
}

class Book extends LibraryItem {
  const Book({
    required super.title,
    required super.year,
    required this.author,
  });

  final String author;

  @override
  String describe() => '$title ($year) — $author';
}

class Magazine extends LibraryItem {
  const Magazine({
    required super.title,
    required super.year,
    required this.issueNumber,
  });

  final int issueNumber;

  @override
  String describe() => '$title ($year), випуск $issueNumber';
}

class Library {
  // Приватний список захищає колекцію від зовнішньої зміни.
  final List<LibraryItem> _items = [];

  void addItem(LibraryItem item) => _items.add(item);

  List<LibraryItem> findByYear(int year) =>
      _items.where((item) => item.year == year).toList();

  List<String> get allDescriptions =>
      _items.map((item) => item.describe()).toList();

  LibraryItem? findOldest() {
    if (_items.isEmpty) return null;
    var oldest = _items.first;
    for (final item in _items.skip(1)) {
      if (item.year < oldest.year) oldest = item;
    }
    // За однакових років повертаємо перший доданий елемент.
    return oldest;
  }
}
