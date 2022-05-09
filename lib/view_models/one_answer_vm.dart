import 'dart:async';
import 'package:flutter/material.dart';
import '../models/one_answer_model.dart';
import '../network/response.dart';
import '../services/api_service.dart';
import '../utils/logger.dart';

class OneAnswerViewModel extends ChangeNotifier {
  final ApiService _apiService;
  int numberOfQuestion = 0;
  int counterOfRightAnswers = 0;
  bool isOneAnswerQuizCompleted = false;

  NetworkResponse<List<OneAnswerModel>> postsListResponse =
      NetworkResponse.none();
  NetworkResponse publishPostResponse = NetworkResponse.none();

  OneAnswerViewModel(this._apiService);

  // If the parameter represents a nullable type, that is, it supports null,
  // then we can not specify a default value, then the default value will be null:
  Future<void> checkAnswers(String usersAnswer,
      {Function()? onQuizCompleted}) async {
    if (usersAnswer == postsListResponse.data?[numberOfQuestion].rightAnswer) {
      counterOfRightAnswers++;
    }
    incrementNumberOfQuestion();

    if (isOneAnswerQuizCompleted) {
      onQuizCompleted!();
    }
    notifyListeners();
  }

  void incrementNumberOfQuestion() {
    if (numberOfQuestion < postsListResponse.data!.length - 1) {
      numberOfQuestion++;
    } else {
      isOneAnswerQuizCompleted = true;
    }
  }

  Future<void> fetchPostsOneAnswer() async {
    postsListResponse =
        NetworkResponse<List<OneAnswerModel>>.loading('Fetching posts...');
    try {
      final postList = await _apiService.fetchPostsDataOneAnswer();
      postsListResponse = NetworkResponse.completed(postList);
      notifyListeners();
    } catch (e) {
      postsListResponse = NetworkResponse.error(e.toString());
      log.fine('fetchPosts error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> publishPostOneAnswer(
      String title, String body, int userId) async {
    publishPostResponse = NetworkResponse.loading('Publishing post...');
    notifyListeners();
    try {
      final postList = await _apiService.publishPostDataOneAnswer(body);
      publishPostResponse = NetworkResponse.completed(postList);
    } catch (e) {
      publishPostResponse = NetworkResponse.error(e.toString());
      log.severe('publishPost error: $e');
    } finally {
      notifyListeners();
    }
  }
}
