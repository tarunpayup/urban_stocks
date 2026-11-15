import 'package:riverpod_based_app/apiservice.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Post{
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      id: json['id'] as int, 
      title: json['title'] as String, 
      body: json['body'] as String
      ); 
  }


}

class PostApiService{
   final http.Client _client;

   PostApiService(this._client);

   Future<List<Post>> fetchPost() async{
      final response = await _client.get(
        Uri.parse("uri")
      );

      if(response.statusCode != 200){
        throw Exception("Failed to load posts");
      }

      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
   }
   
   }
   
class PostRepository{
  final PostApiService _apiService;

  PostRepository(this._apiService);

  Future<List<Post>> getPost(){
    return _apiService.fetchPost();
  }
}

final httpClientProvider = Provider<http.Client>((ref){
  return http.Client();
});

final postApiServiceProvider = Provider<PostApiService>((ref){
  return PostApiService(ref.watch(httpClientProvider));
});

final postRepositoryProvider = Provider<PostRepository>((ref){
  return PostRepository(ref.watch(postApiServiceProvider));
});

final postsProvider = FutureProvider<List<Post>>((ref) async{
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPost();
});