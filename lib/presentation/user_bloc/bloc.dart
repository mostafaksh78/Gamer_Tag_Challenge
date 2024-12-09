import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:gamer_tag/presentation/user_bloc/event/event.dart';
import 'package:gamer_tag/presentation/user_bloc/state/state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  int userIndex = 0;
  bool directionOfChange = true;
  late List<User> users;
  final ChangeUserUseCase changeUserUseCase;
  final InitialUserUseCase initialUserUseCase;
  UserBloc({required this.changeUserUseCase,required this.initialUserUseCase}) : super(LoadingUsers()) {
    on<UsersLoadedEvent>(
      (event, emit) {
        users = event.users;
        userIndex = event.index;
        User user = event.users[userIndex];
        emit(
          ShowUser(user),
        );
      },
    );
    on<UserChangeEvent>(
      (event, emit) {
        if (directionOfChange) {
          if (userIndex >= users.length - 1) {
            directionOfChange = false;
          }
        }
        if (!directionOfChange) {
          if (userIndex <= 0) {
            directionOfChange = true;
          }
        }
        if (directionOfChange) {
          if (userIndex < users.length - 1) {
            userIndex++;
          }
        } else {
          if (userIndex > 0) {
            userIndex--;
          }
        }
        User user = users[userIndex];
        changeUserUseCase(user);
        emit(
          ShowUser(user),
        );
      },
    );

    initialUserUseCase(null).then(
      (value) {

        add(UsersLoadedEvent(value.$1,value.$2));
      },
    );

  }
}
