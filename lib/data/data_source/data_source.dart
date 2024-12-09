import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/data/entity/user.dart';

abstract class MessageSource {
  Future<List<MessageEntity>> loadMessages(int from, int to, UserEntity user);

  Future<List<UserEntity>> loadUsers();

  Future<void> sendMessage(MessageEntity message, UserEntity user);

  Future<void> removeMessage(MessageEntity message, UserEntity user);
}
