import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importing services for clipboard functionality
import 'wishes.dart'; // Importing the wishes file

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

class BirthdayWishesHomeState extends State<BirthdayWishesHome>
    with SingleTickerProviderStateMixin {
  final List<String> relations = ['Friend', 'Sister', 'Brother', 'Mom', 'Dad'];
  String selectedRelation = 'Friend';

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(); // Start animation for default selection
  }

  void copyWish(String wish) {
    Clipboard.setData(ClipboardData(text: wish)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied: $wish')),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      _controller.forward(
                          from: 0.0); // Reset and start animation
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedRelation == relation
                        ? const Color.fromARGB(255, 216, 237, 255)
                        : const Color.fromARGB(255, 255, 255,
                            255), // Change color based on selection
                  ),
                  child: Text(relation),
                );
              }).toList(),
            ),
          ),
          // List of Wishes
          Expanded(
            child: FadeTransition(
              opacity: _animation,
              child: ListView.builder(
                itemCount: wishes[selectedRelation]?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(wishes[selectedRelation]![index]),
                      trailing: ElevatedButton(
                        onPressed: () =>
                            copyWish(wishes[selectedRelation]![index]),
                        child: const Text('Copy'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
