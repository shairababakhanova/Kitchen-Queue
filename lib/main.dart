import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_queue/feautures/auth/blocs/auth_cubit.dart';
import 'package:kitchen_queue/feautures/comment/blocs/comment_cubit.dart';
import 'package:kitchen_queue/feautures/core/router.dart';
import 'package:kitchen_queue/feautures/queue/blocs/queue_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit() 
          ),
        BlocProvider(
          create: (context) => QueueCubit(),
        ),
        BlocProvider(
          create: (context) => CommentCubit(),
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