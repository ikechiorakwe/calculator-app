import 'package:flutter/material.dart';
import 'package:calculator_app/widgets/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = 
  [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'AC', '=',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[100],
      appBar: AppBar(        
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(height: 1,),
          Expanded(
            // flex: 1,
            child: Container( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[                  
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(fontSize: 20),)),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 20),)),
                ],
              ),             
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(              
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index ) {
                  if (index == 0) {
                    return Buttons(
                    buttonTapped: () {
                      setState(() {
                       userQuestion = '' ; 
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
                  );
                  }else if (index == 1) {
                    return Buttons(
                    buttonTapped: () {
                      setState(() {
                       userQuestion = userQuestion.substring(0, userQuestion.length-1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                    
                  );
                  } else if (index == buttons.length-1) {
                    return Buttons(
                    buttonTapped: () {
                      setState(() {
                       equalPressed();                       
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                    
                  );
                  } else if (index == buttons.length-2 ) {
                    return Buttons(
                    buttonTapped: () {
                      setState(() {
                       userAnswer = '0';                      
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.white,
                    textColor: Colors.black,
                    
                  );
                  } else {
                    return Buttons(
                    buttonTapped: () {
                      setState(() {
                       userQuestion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])? Colors.deepPurple : Colors.deepPurple[50],
                    textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                  );
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
 
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}