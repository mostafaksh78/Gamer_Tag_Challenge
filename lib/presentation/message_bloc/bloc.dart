import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:gamer_tag/presentation/message_bloc/event/event.dart';
import 'package:gamer_tag/presentation/message_bloc/state/state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final LoadUseCase loadUseCase;
  final RemoveMessageListenUseCase removeListenerUseCase;
  final NewMessageListenUseCase newListenerUseCase;
  final RemoveMessageUseCase removeMessageUseCase;
  final UserChangeListenUseCase userChangeListenUseCase;
  final InitialUserUseCase initialUserUseCase;
  final int loadStep = 100;
  final bufferLength = 300;
  final List<Entity> data;
  late User user;
  int from = 0;
  int to = 0;
  final List<int> dismissedIndices = [];

  MessageBloc(
      {required this.removeMessageUseCase,
      required this.removeListenerUseCase,
      required this.newListenerUseCase,
      required this.loadUseCase,
      required this.userChangeListenUseCase,
      required this.initialUserUseCase})
      : data = [],
        super(Loading()) {
    on<NewMessageArrived>(
      (event, emit) {
        data.insert(0, event.message);
        reorderBuffer(false);
        emit(
          MessageArriveState(data, 0),
        );
      },
    );
    on<MessageLoaded>(
      (event, emit) {
        data.addAll(event.data);
        reorderBuffer(true);
        emit(MessageShow(data));
      },
    );
    on<MessageRemoved>(
      (event, emit) {
        var index = data.indexOf(event.message);
        var entity = data[index];
        data.removeAt(index);
        if (dismissedIndices.contains(index)) {
          dismissedIndices.remove(index);
        } else {
          emit(
            MessageRemoveState(entity, index),
          );
        }
      },
    );
    on<RemoveMessage>(
      (event, emit) {
        var message = data[event.index];
        dismissedIndices.add(event.index);
        if (message is Message) {
          removeMessageUseCase((message, user));
        }
      },
    );
    on<LoadNewMessages>(
      (LoadNewMessages event, emit) async {
        to = to + loadStep;
        from = from + loadStep;
        var data = await loadUseCase((from, to, user));
        this.data.addAll(data);
        reorderBuffer(true);
        emit(MessageShow(this.data));

        emit(NewMessageLoaded(from, to));
      },
    );
    on<LoadPreviousMessages>(
      (LoadPreviousMessages event, emit) async {
        from = from - loadStep;
        if (from < 0) from = 0;
        to = to - loadStep;
        if (to < loadStep) to = loadStep;
        var data = await loadUseCase((from, to, user));
        this.data.insertAll(0, data);
        reorderBuffer(false);
        emit(MessageShow(this.data));

        emit(NewMessageLoaded(from, to));
      },
    );
    to = from + loadStep;
    removeListenerUseCase.outputStream.listen(
      (event) {
        if (event.$1 == user) {
          add(
            MessageRemoved(event.$2),
          );
        }
      },
    );
    newListenerUseCase.outputStream.listen(
      (event) {
        if (event.$1 == user) {
          add(
            NewMessageArrived(event.$2),
          );
        }
      },
    );
    on<MessageStartLoading>(
      (event, emit) {
        emit(Loading());
      },
    );
    userChangeListenUseCase.outputStream.listen(
      (event) {
        user = event;
        from = 0;
        to = from + loadStep;
        data.clear();
        add(MessageStartLoading());
        loadUseCase((from, to, user)).then(
          (value) {
            add(
              MessageLoaded(value),
            );
          },
        );
      },
    );
    initialUserUseCase.call(null).then(
      (value) {
        user = value.$2[value.$1];
        loadUseCase((from, to, user)).then(
          (value) {
            add(
              MessageLoaded(value),
            );
          },
        );
      },
    );
  }

  int reorderBuffer(bool direction) {
    int ret = 0;
    if (direction) {
      while (this.data.length > bufferLength) {
        this.data.removeAt(0);
        ret ++;
      }
    } else {
      while (this.data.length > bufferLength) {
        this.data.removeLast();
        ret ++;
      }
    }
    return ret;
  }
}
