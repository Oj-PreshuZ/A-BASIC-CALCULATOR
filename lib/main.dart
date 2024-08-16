// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:calculator_app/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      userQuestion,
                      style: TextStyle(fontSize: 40, color: Colors.grey),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 70),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            userAnswer = '';
                            userQuestion = '';
                          });
                        },
                      );
                    }
                    // Delete Button
                    else if (index == 1) {
                      return MyButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                      );
                    }
                    // equal to button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        color: Color.fromARGB(255, 44, 114, 172),
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                      );
                    }

                    // rest of buttons
                    return MyButton(
                      color: isOperator(buttons[index])
                          ? const Color.fromARGB(255, 8, 92, 160)
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
