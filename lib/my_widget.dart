import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_based_app/repository.dart';

class PostScreen extends ConsumerWidget{
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final postAsync = ref.watch(postsProvider);

    return postAsync.when(
      data: (posts) => ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context,index) => ListTile(
          title: Text(posts[index].title),
          subtitle: Text(posts[index].body),
        ),
      ), 
      error: ((error, stackTrace) => Center(
        child: Text("Error: $error"),
      )), 
      loading: ()=> const Center(
        child: CircularProgressIndicator(),
      ));
  }
}