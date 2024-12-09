import 'package:gamer_tag/data/entity/message.dart';

abstract class MessageState{}
class Loading extends MessageState{}

class MessageArriveState extends MessageState{
  final List<Entity> data;
  final int index;
  MessageArriveState(this.data, this.index);
}
class MessageRemoveState extends MessageState{
  final int index;
  final Entity data;
  MessageRemoveState(this.data,this.index);
}

class MessageShow extends MessageState{
  final List<Entity> data;
  MessageShow(this.data);
}
class NewMessageLoading extends MessageState{
  final List<Entity> data;
  NewMessageLoading(this.data);
}
class NewMessageLoaded extends MessageState{
  final int from,to;
  NewMessageLoaded(this.from,this.to);
}