// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skin_analyzer/pages/arguments/result%20_page_argument.dart';
import 'package:skin_analyzer/pages/onboarding_page.dart';
import 'package:skin_analyzer/pages/processing_page.dart';
import 'package:skin_analyzer/pages/result_page.dart';
import 'package:skin_analyzer/pages/selfie_page.dart';
import 'package:skin_analyzer/pages/survey_page.dart';

class RouteConfig {
  static const String onboarding = '/';
  static const String survey = '/survey';
  static const String selfie = '/selfie';
  static const String processing = '/processing';
  static const String result = '/result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return CupertinoPageRoute(builder: (_) => OnboardingPage());
      case survey:
        return CupertinoPageRoute(builder: (_) => SurveyPage());
      case selfie:
        return MaterialPageRoute(builder: (_) => SelfiePage());
      case processing:
        return MaterialPageRoute(
          builder: (_) => ProcessingPage(
            argument: settings.arguments as ResultPageArgument,
          ),
        );
      case result:
        return MaterialPageRoute(
          builder: (_) => ResultPage(
            argument: settings.arguments as ResultPageArgument,
          ),
        );
      default:
        return CupertinoPageRoute(builder: (_) => Container());
    }
  }
}
