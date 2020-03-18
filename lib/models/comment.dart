class CommentsList {
	final List<PostComment> comments;

	CommentsList({
		this.comments,
	});

	factory CommentsList.fromJson(List<dynamic> parsedJson) {

		List<PostComment> comments = new List<PostComment>();
		comments = parsedJson.map((i)=>PostComment.fromJson(i)).toList();

		return new CommentsList(
				comments: comments
		);
	}
}

class PostComment {
	int postId;
	int id;
	String name;
	String email;
	String body;

	PostComment({this.postId, this.id, this.name, this.email, this.body});

	PostComment.fromJson(Map<String, dynamic> json) {
		postId = json['postId'];
		id = json['id'];
		name = json['name'];
		email = json['email'];
		body = json['body'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['postId'] = this.postId;
		data['id'] = this.id;
		data['name'] = this.name;
		data['email'] = this.email;
		data['body'] = this.body;
		return data;
	}
}
