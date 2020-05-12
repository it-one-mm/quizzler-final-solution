import 'package:flutter/material.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';
import 'package:percent_indicator/percent_indicator.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.

    setState(() {
      if (quizBrain.isFinished()) {
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)

        Alert(
          context: this.context,
          title: "Finished",
          content: Column(
            children: <Widget>[
              Text("You've reached the end of the quiz!"),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total: ${quizBrain.totalQuestions}',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 22.0,
                  ),
                  Text(
                    quizBrain.rightAnswerCount.toString(),
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 22.0,
                  ),
                  Text(
                    '${quizBrain.wrongAnswerCount}',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ).show();

        //HINT! Step 4 Part B is in the quiz_brain.dart
        //TODO: Step 4 Part C - reset the questionNumber, rightAnswerCount and wrongAnswerCount
        quizBrain.reset();

        //TODO: Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }
      //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        bool correctAnswer = quizBrain.correctAnswer;
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          quizBrain.incrementRightAnswer();
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          quizBrain.incrementWrongAnswer();
        }
        quizBrain.nextQuestion();
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
          flex: 2,
          child: Center(
            child: CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 10.0,
              percent: quizBrain.isFinished()
                  ? 1.0
                  : (quizBrain.questionNumber + 1) / quizBrain.totalQuestions,
              backgroundColor: Colors.purple,
              progressColor: Colors.yellow,
              center: Text(
                // you can also write this
//                quizBrain.isFinished()
//                    ? '${quizBrain.totalQuestions}/${quizBrain.totalQuestions}'
//                    : '${quizBrain.questionNumber + 1}/${quizBrain.totalQuestions}',
                quizBrain.isFinished()
                    ? quizBrain.totalQuestions.toString() +
                        '/' +
                        quizBrain.totalQuestions.toString()
                    : (quizBrain.questionNumber + 1).toString() +
                        '/' +
                        quizBrain.totalQuestions.toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
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
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
