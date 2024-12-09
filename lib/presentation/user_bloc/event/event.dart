import 'package:gamer_tag/domain/model/user.dart';

abstract class UserEvent {}

class UserChangeEvent extends UserEvent {}

class UsersLoadedEvent extends UserEvent {
  List<User> users;
  int index;
  UsersLoadedEvent(this.index,this.users);
}
