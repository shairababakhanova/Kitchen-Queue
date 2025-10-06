import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_queue/feautures/comment/blocs/comment_state.dart';
import 'package:kitchen_queue/feautures/comment/models/comment.dart';

class CommentCubit extends Cubit<CommentState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CommentCubit() : super(CommentState()) {
    loadComments();
  }

  Future<void> loadComments() async {
    try {
      emit(state.copyWith(isLoading: true));
      final snapshot = await _firestore.collection('comments').get();
      final comments = snapshot.docs.map((doc) {
        final data = doc.data();
        return Comment(
          id: doc.id,
          authorName: data['authorName'] as String,
          text: data['text'] as String,
          dateTime: DateTime.parse(data['dateTime'] as String),
          imageBase64: data['imageBase64'] as String?,
          queueKey: data['queueKey'] as String,
        );
      }).toList();
      emit(state.copyWith(comments: comments, isLoading: false));
    } catch (e) {
      print('Ошибка загрузки комментариев: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> addComment({
    required String authorName,
    required String text,
    required String queueKey,
    String? imagePath,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));
      String? imageBase64;
      if (imagePath != null) {
        
      }

      final comment = Comment(
        authorName: authorName,
        text: text,
        dateTime: DateTime.now(),
        imageBase64: imageBase64,
        queueKey: queueKey,
      );

      final docRef = await _firestore.collection('comments').add(comment.toJson());
      final updatedComment = comment.copyWith(id: docRef.id);
      final updatedComments = [updatedComment, ...state.comments];

      emit(state.copyWith(comments: updatedComments, isLoading: false));
    } catch (e) {
      print('Ошибка добавления комментария: $e');
      emit(state.copyWith(isLoading: false));
      rethrow; 
    }
  }

  List<Comment> getCommentsForQueue(String queueKey) {
    return state.comments.where((comment) => comment.queueKey == queueKey).toList();
  }

  Future<void> deleteComment(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final newList = List<Comment>.from(state.comments)..removeWhere((comment) => comment.id == id);
      await _firestore.collection('comments').doc(id).delete();
      emit(state.copyWith(comments: newList, isLoading: false));
    } catch (e) {
      print('Ошибка удаления комментария: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}