part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPosts extends PostsEvent{}

class FetchPostDetail extends PostsEvent {
  Post post;

  FetchPostDetail({@required this.post});

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'FetchPostDetail { post: $post }';
}
