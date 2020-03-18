
import 'dart:convert';
import 'dart:io';

import 'package:assignment/models/posts.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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


//
//  Future<Weather> fetchWeather(int locationId) async {
//    final weatherUrl = '$baseUrl/api/location/$locationId';
//    final weatherResponse = await this.httpClient.get(weatherUrl);
//
//    if (weatherResponse.statusCode != 200) {
//      throw Exception('error getting weather for location');
//    }
//
//    final weatherJson = jsonDecode(weatherResponse.body);
//    return Weather.fromJson(weatherJson);
//  }


}
