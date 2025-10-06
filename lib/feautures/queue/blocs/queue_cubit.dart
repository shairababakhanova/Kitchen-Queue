import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_state.dart';
import 'package:kitchen_queue/feautures/queue/models/queue.dart';
import 'package:kitchen_queue/feautures/queue/models/user.dart';

class QueueCubit  extends Cubit<QueueState>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QueueCubit() : super(QueueState());
  List<User> users = [];
  List<Queue> queues = [];

 

  Future<void> loadUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      users = snapshot.docs.map((doc) {
        return User(
          key: doc['key'] as String,
          name: doc['name'] as String, 
          );
      }).toList();
      emit(state.copyWith(users: users));
    } catch (e) {
      print('Ошибка загрузки пользователей $e');
    }
  }
  
 Future<void> loadQueues() async {
  try {
    emit(state.copyWith(queues: []));
    final snapshot = await _firestore.collection('queues').get();
    queues = snapshot.docs.map((doc) {
      final data = doc.data();
      return Queue(
        id: doc.id,
        user: data['user'] != null ? User.fromJson(data['user'] as Map<String, dynamic>) : null,
        date: data['date'] != null ? DateTime.parse(data['date'] as String) : DateTime.now(),
      );
    }).toList();
    emit(state.copyWith(queues: queues));
  } catch (e) {
    print('Ошибка загрузки очередей: $e');
  }
}


  Future<void> addQueue(Queue queue) async {
    try {
      final docRef = await _firestore.collection('queues').add(queue.toJson());
      final newQueue = Queue(
        id: docRef.id,
        user: queue.user, 
        date: queue.date);
        emit(state.copyWith(queues: [...state.queues, newQueue]));
    } catch (e) {
      print('Ошибка добавления дежурства');
      rethrow;
    }
  }

  Future<void> deleteQueue(String id) async {
    try {
      final newQueue = List<Queue>.from(state.queues)..removeWhere((queue) => queue.id == id);
      await _firestore.collection('queues').doc(id).delete();
      emit(state.copyWith(queues: newQueue));
    } catch (e) {
      print('Ошибка удаления очереди: $e');
    }
  }
  void updateSelectedDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateSelectedUser(User? user) {
    emit(state.copyWith(selectedUser: user));
  }

 void clearSelection() {
  final clearedState = QueueState(
    selectedUser: null,
    selectedDate: DateTime.now(),
    queues: state.queues,
    users: users
  );
  emit(clearedState);
}
}