import 'package:assignment/constants.dart';
import 'package:assignment/models/comment.dart';
import 'package:assignment/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';
part 'comment_list.dart';

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
  TextEditingController controller = new TextEditingController();
  List<PostComment> commentsList = null;
  List<PostComment> filteredComment = new List<PostComment>();
  int _radioValue1 = 0;
  String searchHint = "name";

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      if (value == 0) searchHint = "name";
      if (value == 1) searchHint = "email";
      if (value == 2) searchHint = "body";

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsBloc>(context).add(FetchPostDetail(post: widget.post));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state is PostsDetailFetched) {
          setState(() {
            if (state.commentsList != null) {
              commentsList = state.commentsList.comments;
              filteredComment.addAll(commentsList);
            }
          });
        }

        if (state is SearchedComments) {
          setState(() {
            setState(() {
              filteredComment.clear();
              filteredComment.addAll(state.comments);
            });
          });
        }
      },
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
                                          "Comments Search by:",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    : Container(),

                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Radio(
                                      value: 0,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    new Text(
                                      'Name',
                                      style: new TextStyle(fontSize: 16.0),
                                    ),

                                    new Radio(
                                      value: 1,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    new Text(
                                      'Email',
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),

                                    new Radio(
                                      value: 2,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    new Text(
                                      'Body',
                                      style: new TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),

                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3.0),
                                  child: TextField(
                                    onChanged: (value) {
                                      BlocProvider.of<PostsBloc>(context).add(
                                          SearchCommentEvent(
                                              postCommentList: commentsList,
                                              query: value, searchFrom: _radioValue1));
//                                      filterSearchResults(commentsList,value);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Search $searchHint",
                                        hintText: "Search $searchHint",
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.0)))),
                                  ),
                                ),

                                commentsList != null
                                    ? Container(child: CommentListView(filteredComment: filteredComment,))
                                    : Container(),

                                // to check if there is error then show message
                                state is PostsError
                                    ? Constants.customMessage(state.error)
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
}
