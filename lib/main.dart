import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importing services for clipboard functionality
import 'dart:math';
import 'wishes.dart'; // Importing the wishes file
import 'package:confetti/confetti.dart';

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
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  void copyWish(String wish) {
    Clipboard.setData(ClipboardData(text: wish)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied: $wish')),
      );
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: relations.map((relation) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedRelation == relation
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRelation = relation;
                          });
                        },
                        child: Text(
                          relation,
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // List of Wishes
              Expanded(
                child: ListView.builder(
                  itemCount: wishes[selectedRelation]!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(wishes[selectedRelation]![index]),
                      trailing: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween<double>(begin: 1, end: 1),
                        builder: (context, double value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  blurRadius: value * 10,
                                  spreadRadius: value * 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                copyWish(wishes[selectedRelation]![index]);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: const Text('Copy'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
      ],
    );
  }
}
