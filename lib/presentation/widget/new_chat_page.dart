import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/presentation/new_bloc/bloc.dart';
import 'package:gamer_tag/presentation/new_bloc/event/event.dart';
import 'package:gamer_tag/presentation/new_bloc/state/state.dart';
import 'package:gamer_tag/presentation/widget/chat_bubble.dart';
import 'package:gamer_tag/presentation/widget/date_bubble.dart';
import 'package:gamer_tag/presentation/widget/imessage_input_bar.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  late ScrollController controller;
  late final GlobalKey<AnimatedListState> _listKey;
  bool loading = false;

  @override
  void initState() {
    controller = ScrollController();
    _listKey = GlobalKey<AnimatedListState>();
    controller.addListener(
      () {
        if (controller.position.pixels ==
            controller.position.maxScrollExtent ) {
          if (!loading) {
            loading = true;
            setState(() {});
            BlocProvider.of<ListBloc>(context).add(OnScrollEnded());
          }
        } else if (controller.position.pixels ==
            controller.position.minScrollExtent) {
          if (!loading) {
            loading = true;
            setState(() {});
            BlocProvider.of<ListBloc>(context).add(OnScrollReached());
          }
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListBloc, ListState>(
      builder: (context, state) {
        switch (state) {
          case LoadingState state:
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          case ShowDataState state:
            return Column(
              children: [
                Expanded(
                  child: CupertinoScrollbar(
                    controller: controller,
                    child: AnimatedList(
                      // shrinkWrap: true,
                      controller: controller,
                      key: _listKey,
                      padding: const EdgeInsets.all(8.0),
                      initialItemCount:
                          state.data.length,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      itemBuilder: (context, index, animation) {
                        final message = state.data[index];
                        if (message is Message) {
                          return Dismissible(
                            // behavior: HitTestBehavior.opaque,
                            direction: message.sendOrRecieve
                                ? DismissDirection.endToStart
                                : DismissDirection.startToEnd,

                            background: Container(
                              color: CupertinoColors.destructiveRed,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: message.sendOrRecieve
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "Delete",
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(color: CupertinoColors.white),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ),
                            key: ValueKey<Entity>(message),
                            onDismissed: (direction) {
                              BlocProvider.of<ListBloc>(context)
                                  .add(RemoveMessageEventIndex(index));
                            },
                            child: SlideTransition(
                              position: animation.drive(
                                Tween<Offset>(
                                  begin: const Offset(0, 0.5),
                                  end: const Offset(0, 0),
                                ),
                              ),
                              child: ChatBubble(
                                expandValue: 0,
                                message: message,
                              ),
                            ),
                          );
                        } else if (message is Date) {
                          return DateBubble(date: message);
                        }
                        return const Center(
                          child: Text("Unknown Item"),
                        );
                      },
                    ),
                  ),
                ),
                const IMessageInputBar(),
              ],
            );
          default:
            return const Center(
              child: Text("Unknown State"),
            );
        }
      },
      listener: (BuildContext context, ListState state) {
        switch (state) {
          case RefreshDataState state:
            loading = false;
            var indexRemoved = state.indexRemoved;
            var indexInserted = state.indexInserted;
            for (var i in indexInserted) {
              _listKey.currentState?.insertItem(i,
                  duration: const Duration(
                    milliseconds: 10,
                  ));
            }
            for (var i in indexRemoved) {
              _listKey.currentState?.removeItem(
                i,
                (context, animation) {
                  return Container();
                },
              );
            }
            break;
          case RemoveSingleMessageState state:
            _listKey.currentState?.removeItem(
              state.indexRemoved,
                  (context, animation) {
                    return FadeTransition(
                      opacity: animation.drive(Tween(begin: 0, end: 1)),
                      child: ChatBubble(
                        expandValue: 0,
                        message: state.message,
                      ),
                    );
              },
            );
          case RemoveSingleMessageStateWithOutAnimation state:
            _listKey.currentState?.removeItem(
              state.indexRemoved,
                  (context, animation) {
                return Container();
              },
            );
            break;
        }
      },
      buildWhen: (previous, current) {
        return current is! RefreshDataState && current is! RemoveSingleMessageState  && current is! RemoveSingleMessageStateWithOutAnimation;
      },
      listenWhen: (previous, current) {
        return current is RefreshDataState || current is RemoveSingleMessageState || current is RemoveSingleMessageStateWithOutAnimation;
      },
    );
  }
}
