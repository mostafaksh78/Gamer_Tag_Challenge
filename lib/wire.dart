import 'package:gamer_tag/data/data_source/fake/fake_source.dart';
import 'package:gamer_tag/data/repository/repository_impl.dart';
import 'package:gamer_tag/domain/repository/repository.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:get_it/get_it.dart';

Future<void> wire() async {
  FakeSource source = FakeSource();
  Repository repo = RepositoryImpl(source);
  LoadUseCase loadUseCase = LoadUseCase(repo);
  SubmitUseCase submitUseCase = SubmitUseCase(repo);
  NewMessageListenUseCase newMessageListenerUseCase =
      NewMessageListenUseCase(repo);
  RemoveMessageListenUseCase removeMessageListenerUseCase =
      RemoveMessageListenUseCase(repo);
  RemoveMessageUseCase removeMessageUseCase = RemoveMessageUseCase(repo);

  ChangeUserUseCase changeUserUseCase = ChangeUserUseCase();
  UserChangeListenUseCase userChangeListenUseCase =
      UserChangeListenUseCase(changeUserUseCase);

  InitialUserUseCase useCase = InitialUserUseCase(repo);



  GetIt.I.registerSingleton<InitialUserUseCase>(useCase);
  GetIt.I.registerSingleton<ChangeUserUseCase>(changeUserUseCase);
  GetIt.I.registerSingleton<UserChangeListenUseCase>(userChangeListenUseCase);
  GetIt.I.registerSingleton<RemoveMessageUseCase>(removeMessageUseCase);
  GetIt.I.registerSingleton<LoadUseCase>(loadUseCase);
  GetIt.I.registerSingleton<SubmitUseCase>(submitUseCase);
  GetIt.I.registerSingleton<NewMessageListenUseCase>(newMessageListenerUseCase);
  GetIt.I.registerSingleton<RemoveMessageListenUseCase>(
      removeMessageListenerUseCase);
}
