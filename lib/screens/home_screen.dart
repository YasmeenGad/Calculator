import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String UserInput = "";
String Result = "0";
List<String> buttonList = [
  "AC",
  "(",
  ")",
  "/",
  "7",
  "8",
  "9",
  "*",
  "4",
  "5",
  "6",
  "+",
  "1",
  "2",
  "3",
  "-",
  "C",
  "0",
  ".",
  "=",
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.90,
            child: resultWidget(),
          ),
          Expanded(child: ButtomWidget())
        ],
      ),
    ));
  }

  Widget resultWidget() {
    return Container(
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(UserInput, style: TextStyle(fontSize: 32)),
        ),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: Text(Result, style: TextStyle(fontSize: 48)),
        )
      ]),
    );
  }

  Widget ButtomWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Color.fromRGBO(66, 233, 232, 232),
      child: GridView.builder(
          itemCount: buttonList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Button(buttonList[index]);
          }),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return Colors.redAccent;
    }
    if (text == "=" || text == "AC") {
      return Colors.white;
    }
    return Colors.indigo;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Colors.redAccent;
    }
    if (text == "=") {
      return Color.fromARGB(255, 104, 204, 159);
    }
    return Colors.white;
  }

  Widget Button(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtonPress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ]),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: getColor(text))),
        ),
      ),
    );
  }

  handleButtonPress(text) {
    if (text == "AC") {
      UserInput = "";
      Result = "0";
      return;
    }
    if (text == "C") {
      if (UserInput.length > 0) {
        UserInput = UserInput.substring(0, UserInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      Result = calculate();
      if (UserInput.endsWith(".0")) {
        UserInput = UserInput.replaceAll(".0", "");
      }
      if (Result.endsWith(".0")) {
        Result = Result.replaceAll(".0", "");
      }
      UserInput = "";
      return;
    }

    UserInput = UserInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(UserInput);
      var eveluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eveluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
