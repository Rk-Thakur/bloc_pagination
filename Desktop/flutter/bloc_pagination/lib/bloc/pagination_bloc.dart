import 'package:bloc/bloc.dart';
import 'package:bloc_pagination/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  int page = 1;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  PostRepo repo;

  PaginationBloc(this.repo) : super(PaginationInitial(null)) {
    scrollController.addListener(() {
      add(LoadMorePostEvent());
    });
    on<FetchPostEvent>((event, emit) async {
      emit(PostLoadingState(null));
      var posts = await repo.fetchPosts(page);
      emit(PostSuccessState(posts: posts));
    });
    on<LoadMorePostEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadingMore = true;

        page++;
        var posts = await repo.fetchPosts(page);

        emit(PostSuccessState(posts: [...state.posts, ...posts]));
      }
    });
  }
}
