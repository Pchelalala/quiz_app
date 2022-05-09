import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/results_screen.dart';
import '../common/app_bar_config.dart';
import '../localization/keys.dart';
import '../network/response.dart';
import '../services/api_service.dart';
import '../theme/theme.dart';
import '../view_models/one_answer_vm.dart';

class OneAnswerScreen extends StatefulWidget {
  const OneAnswerScreen({Key? key}) : super(key: key);

  @override
  _OneAnswerScreenState createState() => _OneAnswerScreenState();
}

class _OneAnswerScreenState extends State<OneAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    final _apiServiceProvider = context.watch<ApiService>();
    return ChangeNotifierProvider(
        create: (_) => OneAnswerViewModel(_apiServiceProvider),
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
    context.read<OneAnswerViewModel>().fetchPostsOneAnswer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final oneAnswerQuizProvider = context.watch<OneAnswerViewModel>();
    return Scaffold(
        appBar: defaultAppBar(
            context, translate(Keys.App_Bar_One_Answer_Screen_Title)),
        body: _questions(oneAnswerQuizProvider));
  }

  Widget _questions(OneAnswerViewModel oneAnswerQuizProvider) {
    final oneAnswerResponse = oneAnswerQuizProvider.postsListResponse;
    switch (oneAnswerResponse.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildQuizRow(
                oneAnswerQuizProvider.postsListResponse
                    .data?[oneAnswerQuizProvider.numberOfQuestion].question,
                oneAnswerQuizProvider,
                context)
          ],
        );
      case Status.error:
        return Center(child: Text(oneAnswerResponse.message!));
      case Status.none:
      default:
        return const Text('');
    }
  }
}

Widget buildQuizRow(
    String? question, OneAnswerViewModel provider, BuildContext context) {
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
            ...(provider.postsListResponse.data?[provider.numberOfQuestion]
                        .answers ??
                    [])
                .map((answer) => _choiceOptionButton(context, answer, provider))
                .toList(),
          ]),
        ],
      )
    ],
  );
}

Widget _choiceOptionButton(BuildContext context, String choiceName,
    OneAnswerViewModel homeViewModelOneAnswer) {
  return ElevatedButton(
    onPressed: () {
      homeViewModelOneAnswer.checkAnswers(choiceName, onQuizCompleted: () {
        if (context.read<OneAnswerViewModel>().isOneAnswerQuizCompleted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => ResultsScreen(
                      counterOfRightAnswers: context
                          .read<OneAnswerViewModel>()
                          .counterOfRightAnswers)));
        }
      });
    },
    child: Text(choiceName),
  );
}
