import 'package:assignment/models/comment.dart';
import 'package:assignment/models/posts.dart';
import 'package:assignment/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class PostDetail extends StatefulWidget {
  PostDetail({Key key, this.post})
      : assert(post != null),
        super(key: key);

  final Post post;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  double _width = 0.0;
  double _height = 0.0;
  final String title = "Post Detail";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsBloc>(context).add(FetchPostDetail(post: widget.post));
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
                  "${title}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: _width,
                  child: Container(
                      child: state is! LoadingPosts
                          ? Column(
                              children: <Widget>[
                                // if postd detail fetched successfull then show post
                                state is PostsDetailFetched
                                    ? getPostDetail(state.postDetail)
                                    : Container(),

                                state is PostsDetailFetched
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 16),
                                        child: Text(
                                          "Comments:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    : Container(),

                                state is PostsDetailFetched && state.commentsList != null
                                    ? Container(
                                        child: getCommentsList(state.commentsList))
                                    : Container(),

                                // to check if there is error then show message
                                state is PostsError
                                    ? customMessage(state.error)
                                    : Container(),
                              ],
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getPostDetail(Post postDetail) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            ),
          ],
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: ListTile(
        title: Text(
          "${postDetail.title}",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 16.0),
        ),
        subtitle: Text(
          "${postDetail.body}",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget customMessage(String error) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        "${error}",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getCommentsList(CommentsList commentsList) {
    print("Comments: ${commentsList.comments.length}");

    return commentsList.comments.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: commentsList.comments.length,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.0),
            itemBuilder: (context, index) {
              print(index);
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0,
                      ),
                    ],
                    border: Border.all(color: Colors.grey, width: 0.5)),
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                        text: 'Name: ',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${commentsList.comments[index].name}',
                            style: TextStyle(
                                color: Colors.brown, fontSize: 16),
                          )
                        ]),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                              text: 'Email: ',
                              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${commentsList.comments[index].email}',
                                  style: TextStyle(
                                      color: Colors.brown, fontSize: 14),
                                )
                              ]),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Body: ${commentsList.comments[index].body}"))
                    ],
                  ),
                ),
              );
            })
        : customMessage("Comments aren't available.");
  }
}
