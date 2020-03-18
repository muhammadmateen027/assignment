part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends PostsState {}
class LoadingPosts extends PostsState {}

class PostsFetched extends PostsState {
  final PostsList postsList;

  const PostsFetched({@required this.postsList});

  @override
  List<Object> get props => [postsList];

  @override
  String toString() => 'PostsFetched { postsList: $postsList }';
}

class PostsDetailFetched extends PostsState {
  Post postDetail;
  CommentsList commentsList;

  PostsDetailFetched({@required this.postDetail, @required this.commentsList});

  @override
  List<Object> get props => [postDetail, commentsList];

  @override
  String toString() => 'PostsDetailFetched { postDetail: $postDetail , commentsList: $commentsList }';
}

class PostsError extends PostsState {
  final String error;

  const PostsError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PostsError { error: $error }';
}
class CommentsError extends PostsState {
  final String error;

  const CommentsError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CommentsError { error: $error }';
}


class SearchedComments extends PostsState {
  List<PostComment> comments;

  SearchedComments({@required this.comments,});

  @override
  List<Object> get props => [comments,];

  @override
  String toString() => 'SearchedComments { query: $comments }';
}
