import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculadoraHomePage(),
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  @override
  _CalculadoraHomePageState createState() => _CalculadoraHomePageState();
}

class _CalculadoraHomePageState extends State<CalculadoraHomePage> {
  String display = '0';
  double? num1;
  double? num2;
  String? operand;
  String? result;

  void buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      setState(() {
        display = '0';
        num1 = null;
        num2 = null;
        operand = null;
        result = null;
      });
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/') {
      if (num1 == null) {
        num1 = double.parse(display);
        operand = buttonText;
        setState(() {
          display += buttonText;
        });
      } else {
        num2 = double.parse(display);
        calculate();
        operand = buttonText;
        setState(() {
          display += buttonText;
        });
      }
    } else if (buttonText == '.') {
      if (!display.contains('.')) {
        setState(() {
          display += buttonText;
        });
      }
    } else if (buttonText == '=') {
      if (num1 != null && operand != null) {
        num2 = double.parse(display.substring(display.indexOf(operand!) + 1));
        calculate();
        setState(() {
          if (result!.endsWith('.0')) {
            display = result!.substring(0, result!.length - 2);
          } else {
            display = result!;
          }
          num1 = double.parse(result!);
          num2 = null;
          operand = null;
          result = null;
        });
      }
    } else {
      setState(() {
        if (display == '0' || display == '') {
          display = buttonText;
        } else {
          display += buttonText;
        }
      });
    }
  }

  void calculate() {
    switch (operand) {
      case '+':
        result = (num1! + num2!).toString();
        break;
      case '-':
        result = (num1! - num2!).toString();
        break;
      case 'x':
        result = (num1! * num2!).toString();
        break;
      case '/':
        result = (num1! / num2!).toString();
        break;
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  display,
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('/'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('x'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('.'),
                buildButton('0'),
                buildButton('C'),
                buildButton('+'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
