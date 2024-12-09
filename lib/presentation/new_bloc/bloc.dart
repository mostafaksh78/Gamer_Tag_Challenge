import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:gamer_tag/presentation/new_bloc/event/event.dart';
import 'package:gamer_tag/presentation/new_bloc/state/state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final LoadUseCase loadUseCase;
  final RemoveMessageListenUseCase removeListenerUseCase;
  final NewMessageListenUseCase newListenerUseCase;
  final RemoveMessageUseCase removeMessageUseCase;
  final UserChangeListenUseCase userChangeListenUseCase;
  final InitialUserUseCase initialUserUseCase;
  late User user;
  final List<Entity> data;
  final int loadStep = 100;
  final int buffer = 10000;
  int allFrom = 0;
  int allTo = 0;

  ListBloc({
    required this.removeMessageUseCase,
    required this.removeListenerUseCase,
    required this.newListenerUseCase,
    required this.loadUseCase,
    required this.userChangeListenUseCase,
    required this.initialUserUseCase,
  })  : data = [],
        super(LoadingState()) {
    on<OnScrollEnded>(
      (OnScrollEnded event, Emitter<ListState> emit) async {
        allTo += loadStep;
        var from = allTo - loadStep;
        var newData = await loadUseCase(
          (from, allTo, user),
        );
        var (toInsert, toRemove) = processNewData(newData, true);
        allFrom += toRemove.length;
        emit(RefreshDataState(toInsert, toRemove));
      },
    );
    on<OnScrollReached>(
      (OnScrollReached event, Emitter<ListState> emit) async {
        if (allFrom != 0) {
          allFrom -= loadStep;

          if (allFrom < 0) {
            allFrom = 0;
          }
          var to = allFrom + loadStep;
          var newData = await loadUseCase(
            (allFrom, to, user),
          );

          var (toInsert, toRemove) = processNewData(newData, false);
          allTo -= toRemove.length;
          emit(RefreshDataState(toInsert, toRemove));
        }
      },
    );
    on<DataProvided>(
      (event, emit) {},
    );
    on<UserLoaded>(
      (event, emit) async {
        user = event.user;
        allFrom = 0;
        allTo = allFrom + loadStep;
        data.addAll(
          await loadUseCase(
            (allFrom, allTo, user),
          ),
        );
        emit(ShowDataState(data));
      },
    );
    on<RemoveMessageEvent>(
      (event, emit) {
        if (data.contains(event.message)) {
          var index = data.indexOf(event.message);
          var message = data.removeAt(index);
          if (message is Message) {
            emit(RemoveSingleMessageState(message, index));
          }
        }
      },
    );
    on<RemoveMessageEventIndex>(
          (event, emit) {

          var message = data.removeAt(event.index);
          if (message is Message) {
            emit(RemoveSingleMessageStateWithOutAnimation(message, event.index));
          }

      },
    );
    on<StartLoadingEvent>(
      (event, emit) {
        data.clear();
        allFrom = 0;
        allTo = 0;
        emit(LoadingState());
      },
    );
    on<MessageInsertedEvent>(
      (event, emit) {
        data.insert(0, event.message);
        emit(RefreshDataState([0], []));
      },
    );
    removeListenerUseCase.outputStream.listen(
      (event) {
        if (event.$1 == user) {
          add(RemoveMessageEvent(event.$2));
        }
      },
    );
    newListenerUseCase.outputStream.listen(
      (event) {
        if (event.$1 == user) {
          add(MessageInsertedEvent(event.$2));
        }
      },
    );

    userChangeListenUseCase.outputStream.listen(
      (event) {
        add(StartLoadingEvent());
        var user = event;
        add(UserLoaded(user));
      },
    );
    initialUserUseCase.call(null).then(
      (value) {
        var user = value.$2[value.$1];
        add(UserLoaded(user));
      },
    );
  }

  (List<int>, List<int>) processNewData(List<Entity> newData, bool direction) {
    if (direction) {
      data.addAll(newData);
      if (data.length > buffer) {
        int mustToPop = data.length - buffer;
        data.removeRange(0, mustToPop);
        int insertedMaxIndex = data.length - 1; // 999
        int insertedMinIndex = data.length - newData.length;
        int removeMinIndex = 0;
        int removeMaxIndex = mustToPop - 1;
        return (
          List<int>.generate(insertedMaxIndex - insertedMinIndex + 1, (index) {
            return insertedMinIndex + index;
          }),
          List<int>.generate(removeMaxIndex - removeMinIndex + 1, (index) {
            return removeMinIndex + index;
          })
        );
      } else {
        int insertedMaxIndex = data.length - 1; // 999
        int insertedMinIndex = data.length - newData.length;
        return (
          List<int>.generate(insertedMaxIndex - insertedMinIndex + 1, (index) {
            return insertedMinIndex + index;
          }),
          []
        );
      }
    } else {
      data.insertAll(0, newData);
      if (data.length > buffer) {
        int mustToPop = data.length - buffer;
        data.removeRange(data.length - mustToPop, data.length);
        int insertedMaxIndex = newData.length - 1; // 999
        int insertedMinIndex = 0;
        int removeMinIndex = data.length - mustToPop;
        int removeMaxIndex = data.length - 1;
        return (
          List<int>.generate(insertedMaxIndex - insertedMinIndex + 1, (index) {
            return insertedMinIndex + index;
          }),
          List<int>.generate(removeMaxIndex - removeMinIndex + 1, (index) {
            return removeMinIndex + index;
          })
        );
      } else {
        int insertedMaxIndex = newData.length - 1; // 999
        int insertedMinIndex = 0;
        return (
          List<int>.generate(insertedMaxIndex - insertedMinIndex + 1, (index) {
            return insertedMinIndex + index;
          }),
          []
        );
      }
    }
  }
}
