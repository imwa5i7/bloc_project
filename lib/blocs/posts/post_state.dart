import 'package:equatable/equatable.dart';

import '../../data/models/posts_response.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitialState extends PostState {}

class PostProcessingState extends PostState {}

class PostProcessingMoreState extends PostState {}

class PostErrorState extends PostState {
  final String error;

  PostErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class PostFinishedState extends PostState {
  final List<Post> postList;
  PostFinishedState({required this.postList});
}
