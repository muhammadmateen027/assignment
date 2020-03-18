import 'package:assignment/models/posts.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final BuildContext context;
  final Post post;

  const PostItem({
    Key key,
    @required this.context,
    @required this.post,
    @required this.width,
    @required this.onPressed,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      width: width / 1.3,
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            ),
          ],
        border: Border.all(color: Colors.grey, width: 0.5)
      ),
      child: ListTile(
        onTap: onPressed,
        leading: Container(
          child: CircleAvatar(
            child: Text("${post.id}", overflow: TextOverflow.ellipsis,),
          ),
        ),
        title: Text(
          "${post.title}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 16.0),
        ),
        subtitle: Text(
          "${post.body}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
