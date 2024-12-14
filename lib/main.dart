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

class BirthdayWishesHomeState extends State<BirthdayWishesHome>
    with SingleTickerProviderStateMixin {
  final List<String> relations = ['Friend', 'Sister', 'Brother', 'Mom', 'Dad'];
  String selectedRelation = 'Friend';

  final Map<String, List<String>> wishes = {
    'Friend': [
      'Happy Birthday! You get to celebrate not just one but two amazing occasions this season—enjoy every moment of it!',
      'Wishing you a birthday as magical as the holidays! May your December be filled with love, joy, and all your favorite things.',
      '(enter current month) babies are extra special because they bring even more light to this time of year. Have the happiest birthday!',
      'Sending you warm birthday wishes wrapped up in holiday cheer. May your day be merry, bright, and full of cake!',
      'Happy Birthday to someone who makes the winter months a little brighter! May your day be filled with love and joy.',
      '(enter current month) birthdays are one-of-a-kind, just like you! Have a wonderful day and an amazing year ahead.',
      'Your birthday is the perfect reason to pause from the holiday rush and celebrate you! Wishing you a fantastic day.',
      'May your birthday sparkle as much as the holiday lights! Wishing you joy, laughter, and a beautiful year ahead.',
      'Having a birthday during the holidays means double the joy! May your special day be filled with love, laughter, and festive fun.',
      'Here’s to a birthday full of warmth, joy, and all the things that make this season—and you—so wonderful',
    ],
    'Sister': [
      'Love you to the moon and back.',
      'May your day be as amazing as you are.',
      'You deserve all the happiness in the world today and always.',
      'Wishing you a fabulous birthday filled with laughter and love!',
      'Happy birthday to my sister and best friend.',
      'To my beautiful sister, happy birthday! You shine today and every day.',
      'Happy birthday! Thanks for being the best part of my life.',
      'Happy birthday to my rock, my sister, and my first best friend.',
      'To my sister, my hero, my forever friend – happy birthday!',
      'You make the world a better place. Have a fantastic birthday!',
      'Wishing you a magical birthday full of surprises, joy, and as much love as you bring to this world each day.',
      'To my wonderful sister – Let’s make your birthday celebration unforgettable.',
      'Happy birthday, sis! May all your dreams come true this year.',
      'Thank you for always being the best sister – happy birthday!',
      'On your birthday and always – I love you!',
    ],
    'Brother': [
      'Happy birthday, bro! I love you a whole lot.',
      'I’m proud to have you representing the [Last Name] family out there in the world.',
      'Happy birthday to my built-in best friend.',
      'Wishing you a birthday as special as you are.',
      'Happy birthday to my funny, accomplished, kind brother.',
      'I have a feeling this trip around the sun will be a movie.',
      'HBDTTVBBOAT! (Happy Birthday to the very best brother of all time. Keep up!)',
      'Friends may come and go, but siblings are forever. Happy birthday to the best brother.',
      '[Birthday date] is def my favourite holiday. Happy birthday!!!',
      'My life would suck without you, dude.',
      'The title I\'m most proud of is your [sister/brother].',
      'Happy personal new year!',
      'In honour of your birthday, let’s eat, drink, and be merry!',
      'Wishing you a birthday as adventurous as you are!',
      'Happy birthday to my favourite gym buddy.',
      'Let’s make this year one for the record books!',
    ],
    'Mom': [
      'No one compares to you. You’re the best mom ever. Happy birthday!',
      'You mean the world to me, mom. Wishing you the best birthday',
      'Wishing the sweetest woman in the world a happy birthday.',
      'Time to make some wishes, mom. Happy birthday!',
      'I can’t wait to celebrate your special day with you. Happy birthday!',
      'Cheers to another trip around the sun!',
      'You’re the best mother anyone could ever ask for. Happy birthday!',
      'Happy birthday to my favorite person in the whole world.',
      'I’m the luckiest person to have a mom like you. Happy birthday!',
      'You’re one-of-a-kind and I love you so much. Happy birthday, mom!',
      'I love you today, tomorrow and forever. Happy birthday, mom!',
      'Wishing the most wonderful mom the best birthday ever!',
      'Happy birthday to the person who loves me unconditionally.',
      'Happy birthday to my biggest cheerleader!',
      'Wishing my one and only mother a very happy birthday.',
    ],
    'Dad': [
      'Here\'s to the man who taught me everything, and who supported me in every step I took through life, Happy birthday, Dad. I can\'t thank you enough for being in my life.',
      'Thanks, Dad, for being my role model, my go-to guy and our family’s rock. You’re a real-life superhero and you deserve an awesome day.',
      'You are my hero, my best friend, my mentor, you are my biggest source of strength. I hope that your birthday is filled with love. Happy birthday!',
      'You have taught me the meaning of love and strength. I am grateful for all the time I spent with you.',
      'Thank you for always believing in me when no one did and thank you for encouraging me to chase my dreams. You are my rock, Dad.',
      'Thank you for battling the demons that lurked under my bed and in my closet and for making me feel secure and cherished! I love you!',
      'I hope today brings you as much joy and happiness as you bring to everyone who is lucky enough to know you.',
      'No matter how old I get, you’ll always be my forever protector.',
      'I hope you know that I love you with every fiber of my body. Happy birthday to the best dad anyone could ever want.',
      'Thank you for always making me feel safe and loved. Sometimes the simplest things are the most precious and cherished.',
      'You’ve always been my personal superhero. Thank you for all the lessons you’ve taught me over the years. Happy birthday, dad!',
      'Nothing could ever break our special bond. I’m lucky to have such a loving father. Happy birthday!',
      'I can always count on you to lift me when I’m low and encourage me to keep going at my heights. Thank you for being you. Happy birthday, dad.',
    ],
  };

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied: $wish')),
    );
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
