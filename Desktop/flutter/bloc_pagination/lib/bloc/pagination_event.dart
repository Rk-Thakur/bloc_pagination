part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent {}

class FetchPostEvent extends PaginationEvent {}

class LoadMorePostEvent extends PaginationEvent {}
