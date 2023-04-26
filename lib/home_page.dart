import 'package:flutter/material.dart';
import 'package:indus_traveller/call_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _username = TextEditingController();

  Color background = const Color.fromARGB(255, 20, 20, 20);

  void error() {
    setState(() {
      background = Colors.red;
    });
    background = const Color.fromARGB(255, 20, 20, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Enter group name below: ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            flex: 3,
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: _username,
              style: const TextStyle(color: Colors.orangeAccent),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.blue),
                hintText: 'Your Username',
                fillColor: background,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.orangeAccent),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.blue),
                hintText: 'Group name that you want to join.',
                fillColor: background,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: const Text(
                  'Join',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
                onPressed: () {
                  (_controller.text == '' || _username.text == '')
                      ? error()
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CallScreen(_controller.text, _username.text),
                          ),
                        );
                },
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
