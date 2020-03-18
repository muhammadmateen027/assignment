import 'package:assignment/constants/constants.dart';
import 'package:assignment/posts/bloc/posts_bloc.dart';
import 'package:assignment/posts/posts.dart';
import 'package:assignment/repository/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  final PostsRepository postsRepository;

  MainApp({Key key, @required this.postsRepository})
      : assert(postsRepository != null),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<ConnectivityStatus> (
      create: (context) => ConnectivityService().connectionStatusController.stream,
      child: OKToast(
        duration: Duration(seconds: 2),
        position: ToastPosition.bottom,
        backgroundColor: Colors.black.withOpacity(0.8),
        radius: 13.0,
        textStyle: TextStyle(fontSize: 18.0),
        child: MaterialApp(
          title: 'Comments Manager',
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          home: BlocProvider(
            create: (context) => PostsBloc(postsRepository: postsRepository),
            child: PostsList(title: "Posts", postsRepository: postsRepository,),
          ),
        ) ,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 0.0;
  double _height = 0.0;


  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CustomMessageScreen(
          heading: "Slow internet connection",
          message: "Try to connect to another network or you can try later.",
          onPressed: (){},
          imageStr: "assets/images/snail-connection.png",
          height: _height,
          width: _width,
        ),
      ),
    );
  }
}
