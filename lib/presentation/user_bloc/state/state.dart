import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/presentation/input_bloc/state/state.dart';

abstract class UserState{}
class ShowUser extends UserState{
  User user;
  ShowUser(this.user);
}
class LoadingUsers extends UserState{}
