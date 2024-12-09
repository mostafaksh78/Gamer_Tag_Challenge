import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:gamer_tag/presentation/input_bloc/bloc.dart';
import 'package:gamer_tag/presentation/new_bloc/bloc.dart';
import 'package:gamer_tag/presentation/user_bloc/bloc.dart';
import 'package:gamer_tag/presentation/widget/imessage_chat_page.dart';
import 'package:gamer_tag/wire.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await wire();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) {
              return UserBloc(
                initialUserUseCase: GetIt.I.get<InitialUserUseCase>(),
                changeUserUseCase: GetIt.I.get<ChangeUserUseCase>(),
              );
            },
          ),
          BlocProvider<ListBloc>(
            create: (context) {
              return ListBloc(
                  removeMessageUseCase: GetIt.I.get<RemoveMessageUseCase>(),
                  loadUseCase: GetIt.I.get<LoadUseCase>(),
                  removeListenerUseCase:
                  GetIt.I.get<RemoveMessageListenUseCase>(),
                  newListenerUseCase: GetIt.I.get<NewMessageListenUseCase>(),
                  initialUserUseCase: GetIt.I.get<InitialUserUseCase>(),
                  userChangeListenUseCase:
                  GetIt.I.get<UserChangeListenUseCase>());
            },
          ),
          BlocProvider<InputBloc>(
            create: (context) {
              return InputBloc(
                  GetIt.I.get<SubmitUseCase>(),
                  GetIt.I.get<UserChangeListenUseCase>(),
                  GetIt.I.get<InitialUserUseCase>());
            },
          )
        ],
        child: const IMessageChatPage(),
      ),
    );
  }
}
