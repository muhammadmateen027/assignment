import 'package:assignment/posts/post_detail/post_detail.dart';
import 'package:assignment/posts/posts.dart';
import 'package:assignment/repository/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/posts_bloc.dart';

class PostsList extends StatefulWidget {
  PostsList({Key key, this.title, @required this.postsRepository}) : assert(postsRepository != null), super(key: key);

  final String title;
  final PostsRepository postsRepository;

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  double _width = 0.0;
  double _height = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsBloc>(context).add(FetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {},
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  elevation: 0.2,
                  backgroundColor: Colors.white,
                  title: Text(
                    "${widget.title}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.red,),
                      onPressed: () async {
                        BlocProvider.of<PostsBloc>(context).add(FetchPosts());
                      },
                    ),
                  ]),
              body: Container(
                color: Colors.white,
                width: _width,
                child: state is PostsFetched ?  ListView.builder(
                    itemCount: state.postsList.post.length,
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.only(left: 20, right: 20.0, bottom: 20.0),
                    itemBuilder: (context, index) {
                      return PostItem(
                        context: context,
                        height: _height,
                        width: _width,
                        post: state.postsList.post[index],
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider(
                            create: (context) => PostsBloc(postsRepository: widget.postsRepository),
                            child: PostDetail(post: state.postsList.post[index],),
                          )));
                        },
                      );
                    }) : Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
