import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_queue/feautures/comment/blocs/comment_state.dart';
import 'package:kitchen_queue/feautures/comment/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CommentCubit extends Cubit<CommentState> {
  static const String _storageKey = 'comments';
  final SharedPreferences _prefs;

  CommentCubit(this._prefs) : super(CommentState()) {
    loadComments();
  }

  void loadComments() {
    try {
      final String? commentsJson = _prefs.getString(_storageKey);
      if (commentsJson != null && commentsJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(commentsJson);
        final List<Comment> comments = decoded
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
        comments.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        emit(state.copyWith(comments: comments));
      }
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  
  Future<void> _saveComments() async {
    try {
      final List<Map<String, dynamic>> commentsJson = 
          state.comments.map((c) => c.toJson()).toList();
      await _prefs.setString(_storageKey, jsonEncode(commentsJson));
    } catch (e) {
      print('$e');
    }
  }

 
  Future<void> addComment({
    required String authorName,
    required String text,
    required String queueKey,
    String? imagePath,
  }) async {
    emit(state.copyWith(isLoading: true));

    final comment = Comment(
      authorName: authorName,
      text: text,
      dateTime: DateTime.now(),
      imagePath: imagePath,
      queueKey: queueKey,
    );

    final updatedComments = [comment, ...state.comments];
    emit(state.copyWith(comments: updatedComments, isLoading: false)); 
    await _saveComments();
  }

  List<Comment> getCommentsForQueue(String queueKey) {
    return state.comments
        .where((comment) => comment.queueKey == queueKey)
        .toList();
  }

  Future<void> deleteComment(int index) async {
    final newList = List<Comment>.from(state.comments);
    newList.removeAt(index);
    emit(state.copyWith(comments: newList));

    await _saveComments();
  }


}