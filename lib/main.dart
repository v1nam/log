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
      floatingActionButton: FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add),),
      body: items.isNotEmpty ? ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  item.buildDate(),
                  const SizedBox.square(dimension: 30),
                  item.buildTime()]),
                const SizedBox.square(dimension: 50),
                Flexible(child: Text("this is some text that i am writing randomly to fill up space for testing overflow on bigger window and i dont want random nonsense i mean this is random nonsense but like its readable i am just bored my homework shit aaa $index", style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,)),
                const SizedBox.square(dimension: 50),
                Row(children: [
                  item.buildEditBtn(),
                  const SizedBox.square(dimension: 10),
                  item.buildDeleteBtn()
                ])
              ],)
            );
          }) : const Center(child: Text("You don't have any entries", style: TextStyle(fontSize: 32, color: Colors.blueGrey, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic))),
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

  Widget buildDeleteBtn() {
    return ImgButton(action: () {}, img: const Icon(Icons.delete, color: Colors.red), padding: const EdgeInsets.all(12), color: Colors.red);
  }

  Widget buildEditBtn() {
    return ImgButton(action: () {}, img: const Icon(Icons.edit), padding: const EdgeInsets.all(12));
  }
}

class ImgButton extends StatelessWidget {
  const ImgButton(
      {Key? key,
      required this.action,
      required this.img,
      required this.padding,
      this.color = Colors.blue})
      : super(key: key);

  final void Function() action;
  final Widget img;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: action,
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>((states) =>
              BorderSide(
                  color: states.contains(MaterialState.hovered) ? color : Colors.blueGrey,
                  width: 2)),
          padding: MaterialStateProperty.all(padding),
          overlayColor: MaterialStateProperty.all(color.withAlpha(40)),
        ),
        child: img);
  }
}
