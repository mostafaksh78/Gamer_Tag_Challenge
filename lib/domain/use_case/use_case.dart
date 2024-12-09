import 'dart:async';

import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/domain/repository/repository.dart';

abstract class FunctionalUseCase<O, I> {
  O call(I i);
}

class LoadUseCase
    extends FunctionalUseCase<Future<List<Entity>>, (int, int, User)> {
  Repository repository;

  LoadUseCase(this.repository);

  @override
  Future<List<Entity>> call((int, int, User) i) async {
    return await repository.loadData(i.$1, i.$2, i.$3);
  }
}

class SubmitUseCase
    extends FunctionalUseCase<Future<void>, (String, bool, User)> {
  Repository repository;

  SubmitUseCase(this.repository);

  @override
  Future<void> call((String, bool, User) i) async {
    var min = DateTime.now().minute;
    var h = DateTime.now().hour;
    var d = DateTime.now().day;
    var m = DateTime.now().month;
    var y = DateTime.now().year;

    await repository.sendMessage(
        Message(i.$1, y, m, d, h, min, false, true, timer: i.$2), i.$3);
  }
}

class RemoveMessageUseCase
    extends FunctionalUseCase<Future<void>, (Message, User)> {
  Repository repository;

  RemoveMessageUseCase(this.repository);

  @override
  Future<void> call((Message, User) i) async {
    await repository.removeMessage(i.$1, i.$2);
  }
}

class ListenUseCase<T> {
  late final Stream<T> outputStream;
  final Stream<T> inputStream;
  final StreamController<T> _controller;

  ListenUseCase({
    required this.inputStream,
  }) : _controller = StreamController<T>.broadcast() {
    outputStream = _controller.stream;
    inputStream.listen(
      (event) {
        _controller.sink.add(event);
      },
    );
  }

  void dispose() {
    _controller.close();
  }
}

class ChangeUserUseCase extends FunctionalUseCase<void, User> {
  final StreamController<User> _controller;
  late final Stream<User> stream;

  ChangeUserUseCase() : _controller = StreamController.broadcast() {
    stream = _controller.stream;
  }

  @override
  void call(User i) {
    _controller.sink.add(i);
  }
}

class NewMessageListenUseCase extends ListenUseCase<(User, Message)> {
  NewMessageListenUseCase(Repository repo)
      : super(inputStream: repo.newMessageStream);
}

class RemoveMessageListenUseCase extends ListenUseCase<(User, Message)> {
  RemoveMessageListenUseCase(Repository repo)
      : super(inputStream: repo.removeMessageStream);
}

class UserChangeListenUseCase extends ListenUseCase<User>{
  UserChangeListenUseCase(ChangeUserUseCase changeUseUseCase):super(inputStream: changeUseUseCase.stream);
}

class InitialUserUseCase extends FunctionalUseCase<Future<(int,List<User>)>,void>{
  Repository repository;

  InitialUserUseCase(this.repository);

  @override
  Future<(int,List<User>)> call(void i) async {
    var v = await repository.loadUsers();
    return (0,v);
  }
}