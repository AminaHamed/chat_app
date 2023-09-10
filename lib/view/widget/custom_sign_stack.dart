import 'package:flutter/material.dart';

import '../screens/auth/animation/fadeAnimation.dart';

class CustomSignStack extends StatelessWidget {
  const CustomSignStack({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * .44,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/background.png')),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            width: 100,
            height: 250,
            child: FadeAnimation(
                1,
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/light-1.png'))),
                )),
          ),
          Positioned(
            left: 140,
            width: 100,
            height: 150,
            child: FadeAnimation(
                1.3,
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/light-2.png'))),
                )),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 100,
            height: 100,
            child: FadeAnimation(
                1.5,
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/clock.png'))),
                )),
          ),
          Positioned(
            child: FadeAnimation(
                1.6,
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
