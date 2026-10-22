import 'package:flutter/material.dart';
import 'rating_badge.dart';

void main() => runApp(const ModuleControlApp());

class ModuleControlApp extends StatelessWidget {
  const ModuleControlApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Модульний контроль 1',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      );
}

// Завдання 3. Стан належить HomeScreen і зберігається під новим маршрутом.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Рукасов Владислав • Ік-42')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                const Text('Завдання 2. RatingBadge'),
                const SizedBox(height: 12),
                const Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  children: [
                    RatingBadge(rating: 4.7, label: 'Відмінно'),
                    RatingBadge(rating: 2.5, label: 'Середньо'),
                    RatingBadge(rating: 1.2),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('Завдання 3. Лічильник'),
                Text('Лічильник: $_counter'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => setState(() => _counter++),
                  child: const Text('+1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => DetailScreen(counter: _counter),
                      ),
                    );
                  },
                  child: const Text('Детальніше'),
                ),
              ],
            ),
          ),
        ),
      );
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.counter});

  // Передаємо знімок значення лише через конструктор.
  final int counter;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Деталі')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Передане значення: $counter'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      );
}
