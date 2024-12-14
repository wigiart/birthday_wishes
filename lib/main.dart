import 'package:flutter/material.dart';

void main() {
  runApp(const BirthdayWishesApp());
}

class BirthdayWishesApp extends StatelessWidget {
  const BirthdayWishesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Birthday Wishes',
      home: BirthdayWishesHome(),
    );
  }
}

class BirthdayWishesHome extends StatefulWidget {
  const BirthdayWishesHome({Key? key}) : super(key: key);

  @override
  BirthdayWishesHomeState createState() => BirthdayWishesHomeState();
}

class BirthdayWishesHomeState extends State<BirthdayWishesHome> {
  final List<String> relations = ['Friend', 'Sister', 'Brother', 'Mom', 'Dad'];
  String selectedRelation = 'Friend';

  final List<String> wishes = [
    'Wishing you a day filled with love and cheer!',
    'Happy Birthday! May your day be as special as you are.',
    'Cheers to you on your birthday! Enjoy your day!',
    'Wishing you all the happiness in the world on your special day.',
  ];

  void copyWish(String wish) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied: $wish')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎂BIRTHDAY WISHES',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold), // Title color and bold
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Relation Selector
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: relations.map((relation) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedRelation = relation;
                    });
                  },
                  child: Text(relation),
                );
              }).toList(),
            ),
          ),
          // List of Wishes
          Expanded(
            child: ListView.builder(
              itemCount: wishes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(wishes[index]),
                    trailing: ElevatedButton(
                      onPressed: () => copyWish(wishes[index]),
                      child: const Text('Copy'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
