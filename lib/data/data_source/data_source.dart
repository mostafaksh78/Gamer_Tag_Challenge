import 'dart:async';

import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/data/entity/user.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';

abstract class MessageSource {
  Future<List<MessageEntity>> loadMessages(int from, int to, UserEntity user);

  Future<List<UserEntity>> loadUsers();

  Future<void> sendMessage(MessageEntity message, UserEntity user);

  Future<void> removeMessage(MessageEntity message, UserEntity user);

  MessageSource()
      : _newMessageStreamController = StreamController.broadcast(),
        _removeMessageStreamController = StreamController.broadcast() {
    _removeMessageStream = _removeMessageStreamController.stream;
    _newMessageStream = _newMessageStreamController.stream;
  }

  final StreamController<(UserEntity, MessageEntity)>
      _newMessageStreamController;
  final StreamController<(UserEntity, MessageEntity)>
      _removeMessageStreamController;
  late final Stream<(UserEntity, MessageEntity)> _newMessageStream;
  late final Stream<(UserEntity, MessageEntity)> _removeMessageStream;

  Stream<(UserEntity, MessageEntity)> get removeMessageStream =>
      _removeMessageStream;

  Stream<(UserEntity, MessageEntity)> get newMessageStream => _newMessageStream;

  void emitNewMessage(UserEntity user, MessageEntity message) {
    _newMessageStreamController.sink.add((user, message));
  }

  void emitRemoveMessage(UserEntity user, MessageEntity message) {
    _removeMessageStreamController.sink.add((user, message));
  }
}
