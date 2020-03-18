import 'package:dio/dio.dart';
import 'package:meta/meta.dart';


class PostsRepository {
  final PostsApiClient postsApiClient;

  PostsRepository({@required this.postsApiClient})
      : assert(postsApiClient != null);

  Future<Response> getAllPosts() async {
    return await postsApiClient.getAPiResponse("posts");
  }

  Future<Response> getPostDetail(int postId) async {
    return await postsApiClient.getAPiResponse("posts/$postId");
  }

  Future<Response> getPostComments(int postId) async {
    return await postsApiClient.getAPiResponse("comments?postId=$postId");
  }

}


// Api Client used as Data Provider
class PostsApiClient {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';
  final Dio dio;

  PostsApiClient({
    @required this.dio,
  }) : assert(dio != null, );

  Future<Response> getAPiResponse(urlStringParam) async {
    print("$baseUrl/$urlStringParam");
    Response response = Response();
    try {
      dio.options.contentType = Headers.jsonContentType;

      response = await dio.get("$baseUrl/$urlStringParam");
      if (response.statusCode != 200) {
        throw Exception('error getting posts');
      }
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      response.statusCode = 400;
      return response;
    }
  }
}
