import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_queue/feautures/comment/blocs/comment_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kitchen_queue/feautures/core/router.dart';

import 'package:kitchen_queue/feautures/queue/blocs/queue_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QueueCubit(),
        ),
        BlocProvider(
          create: (context) => CommentCubit(prefs),
        ),
      ],
      child: MaterialApp.router(
        title: 'Kitchen Queue',
        routerConfig: AppRouter.router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
      ),
    ),
  );
}