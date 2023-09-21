import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {
  final bool loadingMore;
  LoadPosts(this.loadingMore);
  @override
  List<Object> get props => [];
}
