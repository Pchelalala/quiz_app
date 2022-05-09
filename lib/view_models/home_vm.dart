import 'package:flutter/material.dart';
import '../models/post.dart';
import '../network/response.dart';
import '../services/api_service.dart';
import '../utils/logger.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService;
  NetworkResponse<List<PostModel>> postsListResponse = NetworkResponse.none();
  NetworkResponse publishPostResponse = NetworkResponse.none();

  HomeViewModel(this._apiService);

  Future<void> fetchPosts() async {
    postsListResponse =
        NetworkResponse<List<PostModel>>.loading('Fetching posts...');
    notifyListeners();
    try {
      final postList = await _apiService.fetchPostsData();
      postsListResponse = NetworkResponse.completed(postList);
    } catch (e) {
      postsListResponse = NetworkResponse.error(e.toString());
      log.fine('fetchPosts error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> publishPost(String title, String body, int userId) async {
    publishPostResponse = NetworkResponse.loading('Publishing post...');
    notifyListeners();
    try {
      final postList = await _apiService.publishPostData(body);
      publishPostResponse = NetworkResponse.completed(postList);
    } catch (e) {
      publishPostResponse = NetworkResponse.error(e.toString());
      log.severe('publishPost error: $e');
    } finally {
      notifyListeners();
    }
  }
}
