import 'package:flutter/material.dart';
import 'package:foodyguru_loginscreen/login_screen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                icon: Icon(Icons.logout)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Lottie.asset(
                          'asset/animation/30173-welcome-screen.json',
                          height: 250)),
                  Text(
                    'Hey UserName',
                    style: TextStyle(fontFamily: 'Kodchasan', fontSize: 22),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae aliquam augue. Fusce arcu lacus, lobortis sit amet porta quis, placerat eu libero. Curabitur interdum, orci quis consequat suscipit, lectus nunc laoreet nisl, vel malesuada nulla est eu augue. Ut vel risus ac dolor tempus rutrum sit amet vel mi. ',
                    style: TextStyle(fontFamily: 'Kodchasan', fontSize: 15),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae aliquam augue. Fusce arcu lacus, lobortis sit amet porta quis, placerat eu libero. Curabitur interdum, orci quis consequat suscipit, lectus nunc laoreet nisl, vel malesuada nulla est eu augue. Ut vel risus ac dolor tempus rutrum sit amet vel mi. ',
                    style: TextStyle(fontFamily: 'Kodchasan', fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
