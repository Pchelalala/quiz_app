import '../models/one_answer_model.dart';
import '../models/post.dart';
import '../models/true_or_false_model.dart';
import '../network/api_client.dart';
import '../utils/logger.dart';

const String postsPathTrueOrFalse = '/5d4b54e3-7172-43d0-b924-fe5d51707e8f';
const String postsPathOneAnswer = '/0aeb7418-0c94-41ce-8f5b-09889cf37a58';
const String postsPath = '/posts';

class ApiService {
  late ApiClient _apiClient;

  ApiService(String baseApiUrl) {
    _apiClient = ApiClient(baseApiUrl: baseApiUrl);
  }

  Future<List<PostModel>> fetchPostsData() async {
    try {
      final res = await _apiClient.get(postsPath);
      return List<PostModel>.from(res.map((k) => PostModel.fromJson(k)));
    } catch (e) {
      log.severe('fetchPostsData error: $e');
      rethrow;
    }
  }

  Future<List<TrueOrFalseModel>> fetchPostsDataTrueOrFalse() async {
    try {
      final resTrueOrFalse = await _apiClient.get(postsPathTrueOrFalse);
      return List<TrueOrFalseModel>.from(
          resTrueOrFalse.map((k) => TrueOrFalseModel.fromJson(k)));
    } catch (e) {
      log.severe('fetchPostsData error: $e');
      rethrow;
    }
  }

  Future<List<OneAnswerModel>> fetchPostsDataOneAnswer() async {
    try {
      final resOneAnswer = await _apiClient.get(postsPathOneAnswer);
      return List<OneAnswerModel>.from(
          resOneAnswer.map((k) => OneAnswerModel.fromJson(k)));
    } catch (e) {
      log.severe('fetchPostsData error: $e');
      rethrow;
    }
  }

  Future<PostModel> publishPostData(String jsonBody) async {
    try {
      final response = await _apiClient.post(postsPath, jsonBody);
      return PostModel.fromJson(response);
    } catch (e) {
      log.severe('publishPostData error: $e');
      rethrow;
    }
  }

  Future<TrueOrFalseModel> publishPostDataTrueOrFalse(String jsonBody) async {
    try {
      final responseTrueOrFalse =
          await _apiClient.post(postsPathTrueOrFalse, jsonBody);
      return TrueOrFalseModel.fromJson(responseTrueOrFalse);
    } catch (e) {
      log.severe('publishPostData error: $e');
      rethrow;
    }
  }

  Future<OneAnswerModel> publishPostDataOneAnswer(String jsonBody) async {
    try {
      final responseOneAnswer =
          await _apiClient.post(postsPathTrueOrFalse, jsonBody);
      return OneAnswerModel.fromJson(responseOneAnswer);
    } catch (e) {
      log.severe('publishPostData error: $e');
      rethrow;
    }
  }
}
