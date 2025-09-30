import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_cubit.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_state.dart';
import 'package:kitchen_queue/feautures/queue/models/queue.dart';
import 'package:kitchen_queue/feautures/queue/models/user.dart';

class QueueAddScreen extends StatefulWidget {
  const QueueAddScreen({super.key});

  @override
  State<QueueAddScreen> createState() => _QueueAddScreenState();
}

class _QueueAddScreenState extends State<QueueAddScreen> {

  @override
void initState() {
  super.initState();
  context.read<QueueCubit>().clearSelection();
}

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QueueCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Добавить')),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(onPressed: () {
          context.go('/');
        }, icon: Icon(Icons.arrow_back))

        ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<QueueCubit, QueueState>(
            builder: (context, state) {
              return Column(
                children: [
                  DropdownButton<User>(
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                    hint: const Text('Выбрать дежурного'),
                    value: state.selectedUser,
                    items: cubit.users.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat.name));
                    }).toList(), 
                    onChanged: (value) => cubit.updateSelectedUser(value),),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: state.selectedDate, 
                          firstDate: DateTime(2025), 
                          lastDate: DateTime(2027),
                          
                          );
                          if (date != null) {
                            final newDate = DateTime(
                              date.year, 
                              date.month, 
                              date.day);
                              cubit.updateSelectedDate(newDate);
                          }
                      }, 
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.blueGrey,
                            width: 1.0),
                          
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, 
                          vertical: 12),

                      ),
                      child: Text(DateFormat('dd.MM.yyyy').format(state.selectedDate))),
                      const SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          if (state.selectedUser != null) {
                            cubit.addQueue(
                              Queue(
                                userId: state.selectedUserId,
                                user: state.selectedUser, 
                                date: state.selectedDate),
                            );
                            context.go('/');
                          }
                         
                        }, 
                        child: const Text('Добавить'))
                ],);
            })
          ) ,)
    );
  }
}