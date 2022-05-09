import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/results_screen.dart';
import '../common/app_bar_config.dart';
import '../localization/keys.dart';
import '../network/response.dart';
import '../services/api_service.dart';
import '../theme/theme.dart';
import '../view_models/true_or_false_vm.dart';

class TrueOrFalseScreen extends StatefulWidget {
  const TrueOrFalseScreen({Key? key}) : super(key: key);

  @override
  _TrueOrFalseScreenState createState() => _TrueOrFalseScreenState();
}

class _TrueOrFalseScreenState extends State<TrueOrFalseScreen> {
  @override
  Widget build(BuildContext context) {
    final _apiServiceProvider = context.watch<ApiService>();
    return ChangeNotifierProvider(
        create: (_) => TrueOrFalseViewModel(_apiServiceProvider),
        child: const Question());
  }
}

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<TrueOrFalseViewModel>().fetchPostsTrueOrFalse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final trueOrFalseQuizProvider = context.watch<TrueOrFalseViewModel>();
    return Scaffold(
        appBar: defaultAppBar(
            context, translate(Keys.App_Bar_True_Or_False_Screen_Title)),
        body: _questionsTrueOrFalse(trueOrFalseQuizProvider));
  }

  Widget _questionsTrueOrFalse(TrueOrFalseViewModel quizProviderTrueOrFalse) {
    final trueOrFalseResponse = quizProviderTrueOrFalse.postsListResponse;
    switch (trueOrFalseResponse.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildQuizRow(
                quizProviderTrueOrFalse.postsListResponse
                    .data?[quizProviderTrueOrFalse.numberOfQuestion].question,
                quizProviderTrueOrFalse,
                context)
          ],
        );
      case Status.error:
        return Center(child: Text(trueOrFalseResponse.message!));
      case Status.none:
      default:
        return const Text('');
    }
  }
}

Widget buildQuizRow(
    String? question, TrueOrFalseViewModel provider, BuildContext context) {
  return Column(
    children: [
      Text(
        question!,
        textAlign: TextAlign.center,
        style: TextStyles.notifierTextLabel
            .copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _choiceOptionButton(
                context,
                translate(Keys.Choice_Options_Button_Name_True),
                provider,
                true),
            _choiceOptionButton(
                context,
                translate(Keys.Choice_Options_Button_Name_False),
                provider,
                false),
          ]),
        ],
      )
    ],
  );
}

Widget _choiceOptionButton(BuildContext context, String choiceName,
    TrueOrFalseViewModel homeViewModelOneAnswer, bool trueOrFalseUserChoice) {
  return ElevatedButton(
    onPressed: () {
      homeViewModelOneAnswer.checkAnswers(trueOrFalseUserChoice,
          onQuizCompleted: () {
        if (context.read<TrueOrFalseViewModel>().isTrueOrFalseQuizCompleted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => ResultsScreen(
                      counterOfRightAnswers: context
                          .read<TrueOrFalseViewModel>()
                          .counterOfRightAnswers)));
        }
      });
    },
    child: Text(choiceName),
  );
}
