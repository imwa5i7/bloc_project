import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/blocs/posts/post.dart';
import 'package:job_task/data/remote/api_response.dart';
import 'package:job_task/data/repository/posts_repository.dart';

import '../../data/models/posts_response.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository _postsRepository;
  int pageNo = 1;
  bool isFetching = false;
  PostBloc(this._postsRepository) : super(PostInitialState()) {
    on(_loadPosts);
  }

  _loadPosts(LoadPosts event, Emitter<PostState> emit) async {
    if (event.loadingMore) {
      emit(PostProcessingMoreState());
    } else {
      emit(PostProcessingState());
    }

    ApiResponse response = await _postsRepository.loadPosts(pageNo: pageNo);
    if (response.status == Status.completed) {
      emit(PostFinishedState(postList: response.data as List<Post>));
      pageNo++;
      log(pageNo.toString(), name: 'PageNo');
    } else {
      emit(PostErrorState('No More Posts!'));
    }
  }
}
