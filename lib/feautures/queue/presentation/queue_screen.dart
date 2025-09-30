import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_cubit.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_state.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Kitchen Queue')),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(onPressed: () {
            context.go('/add');
          }, icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<QueueCubit, QueueState>(
        builder: (context, state) {
          if (state.queues.isEmpty) {
            return Center(child: Text('Список дежурстcв пуст'));
          }
          return ListView.builder(
            itemCount: state.queues.length,
            itemBuilder: (BuildContext context, int index){
              final queue = state.queues[index];
              return ListTile(
                title: Text('${queue.user?.name}'),
                subtitle: Text(dateFormat.format(queue.date)),
                onTap: () {
                  context.go('/comments', extra: {
                      'queueKey': queue.user?.key, 
                      'userName': queue.user?.name ?? 'Неизвестно',
                      'date': queue.date,
                    },);
                }, 
                trailing: IconButton(
                    onPressed: () => context.read<QueueCubit>().deleteQueue(index), 
                    icon: Icon(Icons.delete)),
              );
            });
        })
    );
  }
}