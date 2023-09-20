// import 'package:job_task/data/remote/api_service.dart';
// import 'package:http/http.dart' as http;
// import '../remote/api_handler.dart';
// import '../remote/api_response.dart';

// class PostsRepository {
//   final ApiService _apiService;
//   PostsRepository(this._apiService);

//   Future<ApiResponse> register(String email, pass) async {
//     try {
//       http.Response response = await _apiService.get('user/posts');
//       ApiResponse result = HandlingResponse.returnResponse(response);
//       if (result.status == Status.completed) {
//         User user = userFromJson(response.body)!;
//         if (user.success!) {
//           result = ApiResponse.completed(user);
//         } else {
//           result = ApiResponse.error(user.message);
//         }
//       }
//       return result;
//     } catch (err) {
//       ApiResponse response = HandlingResponse.returnException(err);
//       return response;
//     }
//   }
// }
