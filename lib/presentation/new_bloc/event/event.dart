import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';

abstract class ListEvent{}

class OnScrollEnded extends ListEvent{}
class OnScrollReached extends ListEvent{}
class DataProvided extends ListEvent{
  final List<Entity> data;
  DataProvided(this.data);
}
class StartLoadingEvent extends ListEvent{}
class UserLoaded extends ListEvent{
  final User user;
  UserLoaded(this.user);
}

class RemoveMessageEvent extends ListEvent{
  final Message message;
  RemoveMessageEvent(this.message);
}
class MessageInsertedEvent extends ListEvent{
  final Message message;
  MessageInsertedEvent(this.message);
}