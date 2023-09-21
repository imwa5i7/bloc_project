import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/blocs/posts/post.dart';

import '../../../config/routes.dart';
import '../../../data/models/posts_response.dart';

class PostsScreen extends StatelessWidget {
  final List<Post> postList = [];
  final ScrollController _scrollController = ScrollController();
  PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(LoadPosts(false));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Posts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  Routes.login,
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xfff5f5f5),
      body: BlocConsumer<PostBloc, PostState>(listener: ((context, state) {
        // on success delete navigator stack and push to home
        if (state is PostFinishedState && state.postList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No More Posts'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
        // on failure show a snackbar
        if (state is PostErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }), builder: (context, state) {
        if (state is PostProcessingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostFinishedState) {
          postList.addAll(state.postList);
          context.read<PostBloc>().isFetching = false;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.offset ==
                              _scrollController.position.maxScrollExtent &&
                          !context.read<PostBloc>().isFetching) {
                        context.read<PostBloc>()
                          ..isFetching = true
                          ..add(LoadPosts(true));
                      }
                    }),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (ctx, i) {
                    return Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(postList[i].title!),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        subtitle: Text(postList[i].body!),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, i) => const SizedBox(height: 16),
                  itemCount: postList.length),
            ),
            if (state is PostProcessingMoreState)
              const Center(child: CircularProgressIndicator())
          ],
        );
      }),
    );
  }
}
