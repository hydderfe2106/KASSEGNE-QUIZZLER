import 'package:quizzler_ipnet/question.dart';

class Quizzbrain{

  int numQuestion=0;
  List<Question>questionBank=[
    Question(questionText:'Le togo a eu son indépendance le 10 novembre 2030.', questionAnswer: false),
    Question(questionText:"L'actuel président du TOGO est Faure GNASSINGBE.", questionAnswer: true),
    Question(questionText:"Etudier n'est pas facile.", questionAnswer: true),
  ];

  String  getQuestionText(){
    return questionBank[numQuestion].questionText;
  }

  bool getQuestionAnswer(){
    return questionBank[numQuestion].questionAnswer;
  }

  int countQuestionBankElement(){
    return questionBank.length;
  }
  void nextQuestion(){
    numQuestion++;
  }
}