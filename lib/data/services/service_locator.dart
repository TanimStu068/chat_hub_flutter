import 'package:chat_hub/data/repositories/auth_repository.dart';
import 'package:chat_hub/data/repositories/chat_repository.dart';
import 'package:chat_hub/data/repositories/contact_repository.dart';
import 'package:chat_hub/data/services/call_log_service.dart';
import 'package:chat_hub/firebase_options.dart';
import 'package:chat_hub/logic/cubits/auth/auth_cubit.dart';
import 'package:chat_hub/logic/cubits/chat/chat_cubit.dart';
import 'package:chat_hub/router/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

Future<void> setupServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  getit.registerLazySingleton(() => AppRouter());
  getit.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getit.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getit.registerLazySingleton(() => AuthRepository());
  getit.registerLazySingleton(() => ContactRepository());
  getit.registerLazySingleton(() => ChatRepository());
  getit.registerLazySingleton(() => CallLogService());

  getit.registerLazySingleton(
    () => AuthCubit(authRepository: AuthRepository()),
  );
  getit.registerFactory(
    () => ChatCubit(
      chatRepository: ChatRepository(),
      currentUserId: getit<FirebaseAuth>().currentUser!.uid,
    ),
  );
}
