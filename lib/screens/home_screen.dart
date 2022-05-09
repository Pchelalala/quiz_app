import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/true_or_false_screen.dart';
import '../common/app_bar_config.dart';
import '../localization/keys.dart';
import '../network/response.dart';
import '../theme/theme.dart';
import '../view_models/home_vm.dart';
import '../view_models/theme_vm.dart';
import 'one_answer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: defaultAppBar(context, translate(Keys.App_Bar_Title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate(Keys.Suggestions_Choose_Lang),
            textAlign: TextAlign.center,
            style: TextStyles.notifierTextLabel
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _buildChangeLangButton(translate(Keys.Language_English), 'en'),
            _buildChangeLangButton(translate(Keys.Language_Ukrainian), 'uk'),
          ]),
          Text(
            translate(Keys.Suggestions_Choose_Quiz_Type),
            textAlign: TextAlign.center,
            style: TextStyles.notifierTextLabel
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _toTrueOrFalseScreen(translate(Keys
                .Route_Buttons_Home_Screen_To_True_Or_False_Screen_Button_Name)),
            _toOneAnswerScreen(
              translate(Keys
                  .Route_Buttons_Home_Screen_To_One_Answer_Screen_Button_Name),
            ),
          ]),
          _buildChangeThemeTile(),
          Text(
            _getText(homeProvider)!,
            textAlign: TextAlign.center,
            style: TextStyles.notifierTextLabel
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  ListTile _buildChangeThemeTile() {
    final themeViewModel = context.watch<ThemeViewModel>();
    return ListTile(
      leading: Text(
        translate(Keys.Theme_Change_Theme),
        style: Theme.of(context).textTheme.headline4,
      ),
      trailing: Switch(
        value: themeViewModel.isLightTheme,
        onChanged: (val) {
          themeViewModel.setThemeData = val;
        },
      ),
    );
  }

  ElevatedButton _buildChangeLangButton(
      String languageName, String languageCode) {
    return ElevatedButton(
      onPressed: () {
        changeLocale(context, languageCode);
      },
      child: Text(languageName),
    );
  }

  ElevatedButton _toTrueOrFalseScreen(String toTrueOrFalseScreenButtonName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TrueOrFalseScreen(),
        ));
      },
      child: Text(toTrueOrFalseScreenButtonName),
    );
  }

  ElevatedButton _toOneAnswerScreen(String toOneAnswerScreenButtonName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OneAnswerScreen(),
        ));
      },
      child: Text(toOneAnswerScreenButtonName),
    );
  }

  String? _getText(HomeViewModel postsViewModel) {
    final postsListResponse = postsViewModel.postsListResponse;
    switch (postsListResponse.status) {
      case Status.loading:
        return postsListResponse.message;
      case Status.completed:
        return '${postsListResponse.data!.length}';
      case Status.error:
        return postsListResponse.message;
      case Status.none:
      default:
        return '';
    }
  }
}
