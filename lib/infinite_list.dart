import 'package:counter_app/blocs/comment_bloc.dart';
import 'package:counter_app/states/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteList();
}

class _InfiniteList extends State<InfiniteList> {
  CommentBloc _commentBloc;
  final _scrollController = ScrollController();
  final _scrollThreadhold = 250.0;

  @override
  void initState() {
    super.initState();
    _commentBloc = BlocProvider.of(context);
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if(maxScrollExtent - currentScroll <= _scrollThreadhold){

      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentStateInitial) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is CommentStateFailure) {
              return Center(
                child: Text(
                  'Cannot load comments from server',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              );
            }

            if (state is CommentStateSuccess) {
              // final state = state as CommentStateSuccess;

              if (state.comments.isEmpty) {
                return Center(
                  child: Text('Empty comments'),
                );
              }

              return ListView.builder(
                itemBuilder: (BuildContext buildContext, int index) {
                  return ListTile(
                    leading: Text('${state.comments[index].email}'),
                    title: Text(
                      '${state.comments[index].name}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    isThreeLine: true,
                    subtitle: Text(
                      '${state.comments[index].body}',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
                itemCount: state.hasReachedEnd
                    ? state.comments.length
                    : state.comments.length + 1,
                // controller: ,
              );
            }
            return Center(
                child: Text(
                    'Other states..')); //never run this line, only fix warning.
          },
        ),
      ),
    );
  }
}
