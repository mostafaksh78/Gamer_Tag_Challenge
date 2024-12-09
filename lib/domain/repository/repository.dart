import 'dart:async';

import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';

abstract class Repository {
  final StreamController<(User,Message)> _newMessageStreamController;
  final StreamController<(User,Message)> _removeMessageStreamController;
  late final Stream<(User,Message)> _newMessageStream;
  late final Stream<(User,Message)> _removeMessageStream;
  Stream<(User,Message)> get removeMessageStream=>_removeMessageStream;
  Stream<(User,Message)> get newMessageStream=>_newMessageStream;
  Repository()
      : _newMessageStreamController = StreamController.broadcast(),
        _removeMessageStreamController = StreamController.broadcast() {
    _removeMessageStream = _removeMessageStreamController.stream;
    _newMessageStream = _newMessageStreamController.stream;
  }

  Future<List<User>> loadUsers();

  Future<List<Entity>> loadData(int from, int to,User user);

  Future<void> sendMessage(Message message,User user);

  void emitNewMessage(User user,Message message){
    _newMessageStreamController.sink.add((user,message));
  }
  void emitRemoveMessage(User user,Message message){
    _removeMessageStreamController.sink.add((user,message));
  }


  Future<void> removeMessage(Message message,User user);
}
