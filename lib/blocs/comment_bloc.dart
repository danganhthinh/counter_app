import 'package:counter_app/events/comment_event.dart';
import 'package:counter_app/services/services.dart';
import 'package:counter_app/states/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentBloc, CommentState> {
  final NUMBER_OF_COMMENTS_PER_PAGE = 20;

  CommentBloc() : super(CommentStateInitial());

  @override
  Stream<CommentState> mapEventToState(CommentBloc event) async* {
    try {
      final hasReachedEndOfOnePage = (state is CommentStateSuccess &&
          (state as CommentStateSuccess).hasReachedEnd);

      if (event is CommentFetchEvent && !hasReachedEndOfOnePage) {
        if (state is CommentStateInitial) {
          //first time loading page
          //1. get comments from api
          //2. yield CommentStateSuccess
          final comments =
              await getCommentsFromApi(0, NUMBER_OF_COMMENTS_PER_PAGE);
          yield CommentStateSuccess(comments: comments, hasReachedEnd: false);
        } else if (state is CommentStateSuccess) {
          //load next page
          // if  next page is empty => yield "CommentStateSuccess" with hasReachedEnd = true
          final currentState = state as CommentStateSuccess;

          int finalIndexOfCurrentPage = currentState.comments.length;
          final comments = await getCommentsFromApi(
              finalIndexOfCurrentPage, NUMBER_OF_COMMENTS_PER_PAGE);

          if (comments.isEmpty) {
            //change current state
            yield currentState.cloneWith(hasReachedEnd: true);
          } else {
            //not empty, means not reached end
            yield CommentStateSuccess(
                comments: currentState.comments + comments,
                hasReachedEnd: false);
          }
        }
      } else {}
    } catch (e) {
      yield CommentStateFailure();
    }
  }
}
