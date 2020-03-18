class PostsList {
  final List<Post> post;

  PostsList({
    this.post,
  });

  factory PostsList.fromJson(List<dynamic> parsedJson) {

    List<Post> post = new List<Post>();
    post = parsedJson.map((i)=>Post.fromJson(i)).toList();

    return new PostsList(
        post: post
    );
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

