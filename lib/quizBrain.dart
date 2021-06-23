import 'package:quizzler/question.dart';

class QuizBrain {
  List<Question> _questionBank = [
    Question('Prince Harry is taller than Prince William'),
    Question('The star sign Aquarius is represented by a tiger'),
    Question('Meryl Streep has won two Academy Awards'),
    Question('Marrakesh is the capital of Morocco'),
    Question(
        'Idina Menzel sings \'let it go\' 20 times in \'Let It Go\' from Frozen'),
    Question('Waterloo has the greatest number of tube platforms in London'),
    Question('M&M stands for Mars and Moordale'),
    Question('Gin is typically included in a Long Island Iced Tea'),
    Question('The unicorn is the national animal of Scotland'),
    Question('There are two parts of the body that can\'t heal themselves'),
    
  ];

  List<Answer> _answerBank = [
    Answer(false),
    Answer(true),
    Answer(false),
    Answer(false),
    Answer(false),
    Answer(true),
    Answer(false),
    Answer(true),
    Answer(true),
    Answer(false),
   
  ];
  int _questionNumber = 0;
  int _pointValue = 0;

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _answerBank[_questionNumber].questionAnswer;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  double percent() {
    return ((_questionNumber) / (_questionBank.length + 1));
  }

  int getQuestionBankLength() {
    return _questionBank.length;
  }

  void nextQuestion() {
    if (_questionNumber < (_questionBank.length - 1)) {
      _questionNumber++;
    }
  }

  void sumPoints() {
    _pointValue = _pointValue + 10;
  }

  int getPoints() {
    return _pointValue;
  }

  int maxPoint() {
    return ((_questionBank.length) * 10);
  }

  bool isFinished() {
    if (_questionNumber >= (_questionBank.length - 1)) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

  void resetPoint() {
    _pointValue = 0;
  }
}
