import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebsafeSvg.asset('assets/icons/bg.svg', fit: BoxFit.fill),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 2), // it will take 2/6
                    Text(
                      'Vamos jogar,',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white),
                    ),
                    Text('Digite seus dados abaixo'),
                    Spacer(), // it will take 1/6
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1C2341),
                        hintText: 'Seu Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))
                        )
                      ),
                    ),
                    Spacer(), // it will take 1/6
                    InkWell(
                      onTap: () => Get.to(() => QuizScreen()),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding * .75),
                        decoration: BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        child: Text(
                          'Vamos Começar',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Spacer(flex: 2), // it will take 2/6 spaces
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
