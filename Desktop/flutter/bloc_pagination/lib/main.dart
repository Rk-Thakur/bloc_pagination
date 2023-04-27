import 'package:bloc_pagination/bloc/pagination_bloc.dart';
import 'package:bloc_pagination/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginationPage(),
    );
  }
}

class PaginationPage extends StatefulWidget {
  const PaginationPage({Key? key}) : super(key: key);

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PostRepo>(
      create: (context) => PostRepo(),
      child: BlocProvider<PaginationBloc>(
        create: (context) =>
            PaginationBloc(context.read<PostRepo>())..add(FetchPostEvent()),
        child: Scaffold(
          body: BlocBuilder<PaginationBloc, PaginationState>(
            builder: (context, state) {
              if (state is PostLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              } else if (state is PostSuccessState) {
                var posts = state.posts;
                return ListView.builder(
                  controller: context.read<PaginationBloc>().scrollController,
                  itemCount: context.read<PaginationBloc>().isLoadingMore
                      ? posts.length + 1
                      : posts.length,
                  itemBuilder: (context, index) {
                    if (index >= posts.length) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    } else {
                      var post = posts[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("${index + 1}"),
                          ),
                          title: Text("${post['id'].toString()}"),
                          subtitle: Text("${post['title'].toString()}"),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
