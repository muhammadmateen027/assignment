import 'package:assignment/posts/bloc/posts_bloc.dart';
import 'package:assignment/posts/posts.dart';
import 'package:assignment/repository/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  final PostsRepository postsRepository;

  MainApp({Key key, @required this.postsRepository})
      : assert(postsRepository != null),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Comments Manager',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: BlocProvider(
        create: (context) => PostsBloc(postsRepository: postsRepository),
        child: PostsList(title: "Posts", postsRepository: postsRepository,),
      ),
    );
  }
}
