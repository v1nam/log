import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: [
        ListItem(DateTime.now()),
        ListItem(DateTime.utc(2007, 12, 11, 18, 42)),
        ListItem(DateTime.utc(2022, 7, 4, 7, 30)),
        ListItem(DateTime.now()),
        ListItem(DateTime.now()),
        ListItem(DateTime.now()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;
  const MyApp({super.key, required this.items});

@override
Widget build(BuildContext context) {
  const title = 'Mixed List';

  return MaterialApp(
    title: title,
    theme: ThemeData.dark(),
    home: Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              item.buildDate(),
              item.buildTime(),
              Text("Testtttttttttttttttttttttttttttttttt $index", style: const TextStyle(fontSize: 16)),
              item.buildTrailing()
            ],
          );
        }),
      ),
    );
  }
}

String formatDate(DateTime date) {
  String day = date.day ~/ 10 == 0 ? "0${date.day}" : "${date.day}";
  String month = date.month ~/ 10 == 0 ? "0${date.month}" : "${date.month}";
  return "$day/$month/${date.year}";
}

String formatTime(DateTime time) {
  String hour = time.hour ~/ 10 == 0 ? "0${time.hour}" : "${time.hour}";
  String minute = time.minute ~/ 10 == 0 ? "0${time.minute}" : "${time.minute}";
  return "$hour : $minute";
}

class ListItem {
  final DateTime date;
  ListItem(this.date);

  Widget buildDate() {
    return Text(formatDate(date), style: const TextStyle(fontSize: 16),);
  }

  Widget buildTime() {
    return Text(formatTime(date), style: const TextStyle(fontSize: 16),);
  }

  Widget buildTrailing() {
    return const Icon(Icons.delete);
  }
}


