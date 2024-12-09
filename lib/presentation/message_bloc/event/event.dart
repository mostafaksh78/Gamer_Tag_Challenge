import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';

abstract class MessageEvent {}

class SendMessage extends MessageEvent {
  final String message;

  SendMessage(this.message);
}

class MessageLoaded extends MessageEvent {
  final List<Entity> data;

  MessageLoaded(this.data);
}
class MessageStartLoading extends MessageEvent{}
class LoadNewMessages extends MessageEvent {}
class LoadPreviousMessages extends MessageEvent {}

class SubmitMessage extends MessageEvent {
  String text;
  bool timer;

  SubmitMessage(this.text, this.timer);
}

class NewMessageArrived extends MessageEvent {
  final Message message;

  NewMessageArrived(this.message);
}

class RemoveMessage extends MessageEvent {
  final int index;

  RemoveMessage(this.index);
}

class MessageRemoved extends MessageEvent {
  final Message message;

  MessageRemoved(this.message);
}
