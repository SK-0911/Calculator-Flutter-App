import 'package:flutter/material.dart';
import 'package:test_flutter/splash.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userInput = "";
  var userOutput = "";

  final List<String> buttons = [  //Visualizing the buttons
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'X',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', '+/-', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(userInput, style: TextStyle(fontSize: 30),),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userOutput, style: TextStyle(fontSize: 30),),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index){
                      // Cancel Button
                      if(index==0){
                        return MyButton(
                            buttonTapped: (){
                              setState(() {
                                userInput = '';
                                userOutput = '';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.green,
                            textColor: Colors.white,
                            );
                      }
                      // Del Button
                      else if(index==1){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userInput = userInput.substring(0, userInput.length -1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                      //Equal Button
                      else if(index==buttons.length-1){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        );
                      }
                      // +/- Button
                      
                      // Rest of the Button
                      else{
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.deepPurple: Colors.deepPurple[50],
                          textColor: isOperator(buttons[index]) ? Colors.white: Colors.deepPurple,
                        );
                      }
                    })
              )
          )
        ],
      ),
    );
  }

  bool isOperator(String x){
    if(x == '%' || x== '/' || x == 'X' || x== '-' || x== '+' || x=='='){
      return true;
    }
    return false;
  }

  bool isOperand(String x){
    if(x == '%' || x== '/' || x == 'X' || x== '-' || x== '+' || x=='='){
      return true;
    }
    return false;
  }

  void equalPressed(){
      String finalInput = userInput;
      finalInput = finalInput.replaceAll('X', '*');
      
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      userOutput = eval.toString();
  }

}
