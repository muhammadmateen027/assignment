import 'dart:async';
import 'package:assignment/models/comment.dart';
import 'package:assignment/models/posts.dart';
import 'package:assignment/repository/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'posts_events.dart';

part 'posts_states.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository;

  PostsBloc({@required PostsRepository postsRepository})
      : assert(postsRepository != null),
        _postsRepository = postsRepository;

  @override
  PostsState get initialState => Uninitialized();

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is FetchPosts) {
      getUniqueNumber([
        4,
        5,
        6,
        5,
        6,
      ]);
      yield LoadingPosts();
      print('Fetching data');
      Response response = await _postsRepository.getAllPosts();
      if (response.statusCode == 200) {
        yield PostsFetched(postsList: PostsList.fromJson(response.data));
      } else
        yield PostsError(
            error:
                "Unable to load post. Please check your internet connection and try again later.");
    }

    if (event is FetchPostDetail) {
      yield LoadingPosts();
      print('Fetching data');
      Response response = await _postsRepository.getPostDetail(event.post.id);
      print(response.data);
      if (response.statusCode == 200) {
        Response commentsResponse =
            await _postsRepository.getPostComments(event.post.id);
        yield PostsDetailFetched(
            postDetail: Post.fromJson(response.data), commentsList: null);
        if (commentsResponse.statusCode == 200) {
          yield PostsDetailFetched(
              postDetail: Post.fromJson(response.data),
              commentsList: CommentsList.fromJson(commentsResponse.data));
        } else
          yield CommentsError(
              error:
                  "Unable to load comments. Please check your internet connection and try again later.");
      } else
        yield PostsError(
            error:
                "Unable to load post. Please check your internet connection and try again later.");
    }

    if (event is SearchCommentEvent) {
      List<PostComment> dummySearchList = List<PostComment>();
      dummySearchList.addAll(event.postCommentList);

      if (event.query.isNotEmpty) {
        List<PostComment> dummyListData = List<PostComment>();
        dummySearchList.forEach((item) {
          if (item.name.toLowerCase().contains(event.query.toLowerCase()) &&
              event.searchFrom == 0) dummyListData.add(item);
          if (item.email.toLowerCase().contains(event.query.toLowerCase()) &&
              event.searchFrom == 1) dummyListData.add(item);
          if (item.body.toLowerCase().contains(event.query.toLowerCase()) &&
              event.searchFrom == 2) dummyListData.add(item);
        });
        yield SearchedComments(comments: dummyListData);
      } else {
        yield SearchedComments(comments: event.postCommentList);
      }
    }
  }


  List<int> getUniqueNumber(List<int> numarray) {
    numarray.sort((a, b) {
      return a.compareTo(b);
    });

    int existingNumber = numarray[0];
    int count = 1;
    for (int i = 1; i < numarray.length; i++) {
      if (existingNumber == numarray[i]) continue;
      else {
        existingNumber = numarray[i];
        count++;
      }
    }

    List<int> result = new List(count);

    count = 0;
    existingNumber = numarray[0];
    result[count++] = existingNumber;
    for (int i = 1; i < numarray.length; i++) {
      if (existingNumber == numarray[i]) continue;
      else {
        existingNumber = numarray[i];
        result[count++] = existingNumber;
      }
    }

    print(result);
    return result;
  }
}
