import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:gamer_tag/presentation/input_bloc/event/event.dart';
import 'package:gamer_tag/presentation/input_bloc/state/state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  bool timer = false;
  final SubmitUseCase submitUseCase;
  final UserChangeListenUseCase userChangeListenUseCase;
  final InitialUserUseCase initialUserUseCase;
  late User user;

  InputBloc(
      this.submitUseCase, this.userChangeListenUseCase, this.initialUserUseCase)
      : super(LoadingInput()) {
    on<UserLoadedEvent>((event, emit) {
      emit(Show(timer));
    });
    on<TimerToggle>(
      (event, emit) {
        timer = !timer;
        emit(Show(timer));
      },
    );
    on<SubmitEvent>(
      (event, emit) async {
        await submitUseCase(
          (event.text, event.timer, user),
        );
      },
    );
    userChangeListenUseCase.outputStream.listen(
      (event) {
        user = event;
      },
    );
    initialUserUseCase.call(null).then(
      (value) {
        user = value.$2[value.$1];
        add(UserLoadedEvent());
      },
    );
  }
}
