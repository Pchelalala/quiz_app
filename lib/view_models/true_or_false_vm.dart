import 'dart:async';
import 'package:flutter/material.dart';
import '../models/true_or_false_model.dart';
import '../network/response.dart';
import '../services/api_service.dart';
import '../utils/logger.dart';

class TrueOrFalseViewModel extends ChangeNotifier {
  final ApiService _apiService;
  int numberOfQuestion = 0;
  int counterOfRightAnswers = 0;
  bool isTrueOrFalseQuizCompleted = false;

  NetworkResponse<List<TrueOrFalseModel>> postsListResponse =
      NetworkResponse.none();
  NetworkResponse publishPostResponse = NetworkResponse.none();

  TrueOrFalseViewModel(this._apiService);

  Future<void> checkAnswers(bool usersAnswer,
      {Function()? onQuizCompleted}) async {
    if (usersAnswer == postsListResponse.data?[numberOfQuestion].rightAnswer) {
      counterOfRightAnswers++;
    }
    incrementNumberOfQuestion();

    if (isTrueOrFalseQuizCompleted) {
      onQuizCompleted!();
    }
    notifyListeners();
  }

  void incrementNumberOfQuestion() {
    if (numberOfQuestion < postsListResponse.data!.length - 1) {
      numberOfQuestion++;
    } else {
      isTrueOrFalseQuizCompleted = true;
    }
  }

  Future<void> fetchPostsTrueOrFalse() async {
    postsListResponse =
        NetworkResponse<List<TrueOrFalseModel>>.loading('Fetching posts...');
    try {
      final postList = await _apiService.fetchPostsDataTrueOrFalse();
      postsListResponse = NetworkResponse.completed(postList);
      notifyListeners();
    } catch (e) {
      postsListResponse = NetworkResponse.error(e.toString());
      log.fine('fetchPosts error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> publishPostTrueOrFalse(
      String title, String body, int userId) async {
    publishPostResponse = NetworkResponse.loading('Publishing post...');
    try {
      final postList = await _apiService.publishPostDataTrueOrFalse(body);
      publishPostResponse = NetworkResponse.completed(postList);
    } catch (e) {
      publishPostResponse = NetworkResponse.error(e.toString());
      log.severe('publishPost error: $e');
    } finally {
      notifyListeners();
    }
  }
}
