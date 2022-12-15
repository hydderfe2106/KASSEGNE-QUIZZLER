import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:quizzler_ipnet/quizzbrain.dart';

Quizzbrain quizzbrain = Quizzbrain();
void main() => runApp(const quizzler());

class quizzler extends StatelessWidget {
  const quizzler({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
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
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /*List<String> questions=[
    'Le togo a eu son indépendance le 05 juillet 1884.',
    "L'actuel président du Togo est Faure GNASSINGBE.",
    "Etudier n'est pas facile.",
  ];
  List<bool>reponse=[false, true, true];*/

  List<Icon> score = [];
  /*Icon(
      Icons.check, color: Colors.green,
    ),
    Icon(
      Icons.close, color: Colors.red,
    )*/

  int numQuestion = 0;

  void incrementation(bool reponse_user) {
    if (quizzbrain.countQuestionBankElement() > score.length) {
      if (reponse_user == quizzbrain.getQuestionAnswer()) {
        score.add(
          const Icon(Icons.check_circle_rounded, color: Colors.green),
        );
      } else {
        score.add(
          const Icon(Icons.close_rounded, color: Colors.red),
        );
      }

      //print(quizzbrain.numQuestion);

      setState(() {
        if (quizzbrain.countQuestionBankElement() > score.length) {
          quizzbrain.nextQuestion();
        }
      });
    }
    if (quizzbrain.countQuestionBankElement() == score.length) {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const Text("NDialog"),
        content: const Text("Vous avez terminé"),
        actions: <Widget>[
          TextButton(
            child: const Text("Recommencer"),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                quizzbrain.numQuestion = 0;
                score = [];
              });
            },
          ),
          TextButton(
            child: const Text("Fermer"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ).show(context);
    }
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
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Vrai',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                incrementation(true);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Faux',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                incrementation(false);
                //The user picked false.
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(children: score)
      ],
    );
  }
}
