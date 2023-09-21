import 'package:job_task/data/models/posts_response.dart';
import 'package:job_task/data/remote/api_service.dart';
import 'package:http/http.dart' as http;
import '../remote/api_handler.dart';
import '../remote/api_response.dart';

class PostsRepository {
  final ApiService _apiService;
  PostsRepository(this._apiService);

  Future<ApiResponse> loadPosts({int pageNo = 1}) async {
    try {
      http.Response response =
          await _apiService.get('/posts?_page=$pageNo&limit=10');
      ApiResponse result = HandlingResponse.returnResponse(response);
      if (result.status == Status.completed) {
        List<Post> postList = postFromJson(response.body);
        if (postList.isNotEmpty) {
          result = ApiResponse.completed(postList);
        } else {
          result = ApiResponse.error(result.message);
        }
      }
      return result;
    } catch (err) {
      ApiResponse response = HandlingResponse.returnException(err);
      return response;
    }
  }
}
