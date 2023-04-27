part of 'pagination_bloc.dart';

@immutable
abstract class PaginationState {
  final posts;
  PaginationState(this.posts);
}

class PaginationInitial extends PaginationState {
  PaginationInitial(super.posts);
}

class PostLoadingState extends PaginationState {
  PostLoadingState(super.posts);
}

class PostSuccessState extends PaginationState {
  PostSuccessState({required posts}) : super(posts);
}
