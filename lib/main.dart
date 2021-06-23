import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzler/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:random_color/random_color.dart';
import 'package:quizzler/dimensions.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  RandomColor _randomColor = RandomColor();
  SizeConfig dimensions = SizeConfig();
  void validateAnswer(bool answerPicked) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    int valueOfPoint_1 = quizBrain.getPoints();
    int maximumPoint = quizBrain.maxPoint();
    setState(() {
      if (quizBrain.isFinished() == true &&
          (valueOfPoint_1 >= (maximumPoint / 2))) {
        Alert(
          context: context,
          title: 'Good!',
          desc: 'You scored $valueOfPoint_1% of $maximumPoint%',
        ).show();
        quizBrain.reset();
        quizBrain.resetPoint();
      } else if (quizBrain.isFinished() == true &&
          (valueOfPoint_1 < (maximumPoint / 2))) {
        Alert(
          context: context,
          title: 'Poor. Do better!',
          desc: 'You scored $valueOfPoint_1 of $maximumPoint',
        ).show();
        quizBrain.reset();
        quizBrain.resetPoint();
      } else {
        if (correctAnswer == answerPicked) {
          setState(() {
            quizBrain.sumPoints();
          });
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int questionNumber = (quizBrain.getQuestionNumber());
    int lengthOfQuestionBank = quizBrain.getQuestionBankLength();
    double percentageDouble = quizBrain.percent();
    int percentage = (percentageDouble * 100).round();
    int valueOfPoint_2 = quizBrain.getPoints();
    Color _color = _randomColor.randomColor();
    double safeWidthBlock = dimensions.safeBlockHorizontalFunc();
    double safeHeightBlock = dimensions.safeBlockVerticalFunc();
    double safeScreenWidth = dimensions.screenWidthSafeFunc();
    double safeScreenHeight = dimensions.screenHeightSafeFunc();

    CircleAvatar circleAvatar(
        {Color circleAvatarColor, double radiusCircleAvatar}) {
      return CircleAvatar(
        backgroundColor: circleAvatarColor,
        radius: radiusCircleAvatar,
      );
    }

    Column columnShii(
        {String word, String num, Color wordTextColor, Color numTextColor}) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '$word',
          style: TextStyle(
            color: wordTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$num',
          style: TextStyle(
            color: numTextColor,
            fontSize: (safeWidthBlock * 5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]);
    }

    TextButton textButton({String text, bool boolShit}) {
      return TextButton(
        child: Text(
          '$text',
          style: TextStyle(
              fontSize: (safeWidthBlock * 7.3), fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          validateAnswer(boolShit);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF5D72F4)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(safeWidthBlock * 5),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF556bf4),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: (safeWidthBlock * 2.4)),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: (safeHeightBlock * 5.344)),
              child: UnconstrainedBox(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (safeWidthBlock * 2.4)),
                  width: safeScreenWidth * 0.65,
                  height: safeScreenHeight * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((safeWidthBlock * 5)),
                    color: Color(0xFF4C62F4),
                  ),
                  child: Row(children: [
                    circleAvatar(
                        circleAvatarColor: Colors.pink,
                        radiusCircleAvatar: (safeWidthBlock * 5)),
                    SizedBox(
                      width: (safeWidthBlock * 2.4),
                    ),
                    columnShii(
                      word: 'Rank',
                      num: '100',
                      numTextColor: Colors.white,
                      wordTextColor: Colors.white,
                    ),
                    SizedBox(
                      width: ((safeScreenWidth * 0.07)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: (safeHeightBlock * 1.07)),
                      child: VerticalDivider(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: (safeWidthBlock * 1.2),
                    ),
                    circleAvatar(
                        circleAvatarColor: Colors.orange,
                        radiusCircleAvatar: (safeWidthBlock * 5)),
                    SizedBox(
                      width: (safeWidthBlock * 2.4),
                    ),
                    columnShii(
                      word: 'Points',
                      num: '$valueOfPoint_2',
                      numTextColor: Colors.white,
                      wordTextColor: Colors.white,
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: (safeHeightBlock * 5.34)),
              child: CircularPercentIndicator(
                radius: (safeWidthBlock * 24),
                lineWidth: (safeWidthBlock * 3),
                animation: true,
                backgroundColor: Color(0xFFB8BDE3),
                percent: percentageDouble,
                center: new Text(
                  "$percentage%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (safeWidthBlock * 5),
                      color: Colors.white),
                ),
                circularStrokeCap: CircularStrokeCap.square,
                progressColor: Color(0xFF4C62F4),
                footer: Padding(
                  padding: EdgeInsets.only(top: (safeHeightBlock * 0.67)),
                  child: Text(
                    'Questions attempted [$questionNumber/$lengthOfQuestionBank]',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (safeWidthBlock * 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: ((safeHeightBlock * 0.27).round()),
              child: Container(
                margin: EdgeInsets.only(top: (safeHeightBlock * 4.01)),
                padding: EdgeInsets.all((safeWidthBlock * 5)),
                width: safeScreenWidth,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular((safeWidthBlock * 5)),
                ),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: (safeWidthBlock * 10),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: (safeHeightBlock * 2.67)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: (safeHeightBlock * 8),
                      child: textButton(text: 'True', boolShit: true),
                    ),
                    SizedBox(height: (safeHeightBlock * 1.34)),
                    SizedBox(
                      height: (safeHeightBlock * 8),
                      child: textButton(text: 'False', boolShit: false),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
