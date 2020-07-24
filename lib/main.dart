import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain=QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Quiz(),
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int quest_no = 0;
  List<Icon> scoreKeeper = [];

  void checkans(bool userans){
    bool correctans=quizBrain.getans();
    setState(() {

      if(quizBrain.quizfinish()==true){
        Alert(
            context: context,
            title: "Quizler App",
            desc: "Quiz is completed.")
            .show();
        quizBrain.resetquiz();
        scoreKeeper=[];

      }
      else{
        if(userans==correctans){
          scoreKeeper.add( Icon(Icons.check, color: Colors.green, size: 40.0),);
        }
        else{
          scoreKeeper.add( Icon(Icons.close, color: Colors.red, size: 40.0),);
        }
        quizBrain.nextquestion();

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getquestion(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkans(true);

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkans(false);

              },
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: scoreKeeper,


          ),
        )),
      ],
    );
  }
}
