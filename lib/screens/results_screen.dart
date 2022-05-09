import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../common/app_bar_config.dart';
import '../localization/keys.dart';
import '../theme/theme.dart';

class ResultsScreen extends StatelessWidget {
  final int counterOfRightAnswers;
  const ResultsScreen({Key? key, required this.counterOfRightAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          defaultAppBar(context, translate(Keys.App_Bar_Results_Screen_Title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate(Keys.Number_Of_Right_Answers) +
                counterOfRightAnswers.toString(),
            textAlign: TextAlign.center,
            style: TextStyles.notifierTextLabel
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
