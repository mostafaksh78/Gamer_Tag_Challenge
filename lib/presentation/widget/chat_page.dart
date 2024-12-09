import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/presentation/message_bloc/bloc.dart';
import 'package:gamer_tag/presentation/message_bloc/event/event.dart';
import 'package:gamer_tag/presentation/message_bloc/state/state.dart';
import 'package:gamer_tag/presentation/widget/chat_bubble.dart';
import 'package:gamer_tag/presentation/widget/date_bubble.dart';
import 'package:gamer_tag/presentation/widget/imessage_input_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController controller;
  late final GlobalKey<AnimatedListState> _listKey;
  bool loading = false;

  @override
  void initState() {
    controller = ScrollController();
    _listKey = GlobalKey<AnimatedListState>();
    controller.addListener(
      () {
        if (controller.position.pixels >
            controller.position.maxScrollExtent * 0.7) {
          if (!loading) {
            loading = true;
            setState(() {});
            BlocProvider.of<MessageBloc>(context).add(LoadNewMessages());
          }
        }else if(controller.position.pixels <
            controller.position.minScrollExtent * 1.3){
          if (!loading) {
            loading = true;
            setState(() {});
            BlocProvider.of<MessageBloc>(context).add(LoadPreviousMessages());
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
    return BlocConsumer<MessageBloc, MessageState>(
      builder: (context, state) {
        switch (state) {
          case Loading state:
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          case MessageShow state:
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
                          loading ? state.data.length + 1 : state.data.length,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      itemBuilder: (context, index, animation) {

                        if (loading) {
                          if(index == state.data.length){
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }
                        }
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
                              BlocProvider.of<MessageBloc>(context)
                                  .add(RemoveMessage(index));
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
      listener: (BuildContext context, MessageState state) {
        switch (state) {
          case MessageArriveState state:
            var index = state.index;

            _listKey.currentState?.insertItem(index,
                duration: const Duration(
                  milliseconds: 100,
                ));
            break;
          case MessageRemoveState state:
            var index = state.index;
            var message = state.data;
            _listKey.currentState?.removeItem(index,
                (BuildContext context, Animation<double> animation) {
              if (message is Message) {
                return FadeTransition(
                  opacity: animation.drive(Tween(begin: 0, end: 1)),
                  child: ChatBubble(
                    expandValue: 0,
                    message: message,
                  ),
                );
              } else if (message is Date) {
                return DateBubble(date: message);
              }
              return const Center(
                child: Text("Unknown Item"),
              );
            },
                duration: const Duration(
                  milliseconds: 100,
                ));
            break;
          case NewMessageLoaded state:
            _listKey.currentState
                ?.insertAllItems(state.from, state.to - state.from,
                    duration: const Duration(
                      milliseconds: 100,
                    ));
            loading = false;
            setState(() {

            });

        }
      },
      buildWhen: (previous, current) {
        return current is! MessageArriveState &&
            current is! MessageRemoveState &&
            current is! NewMessageLoaded;
      },
      listenWhen: (previous, current) {
        return current is MessageArriveState ||
            current is MessageRemoveState ||
            current is NewMessageLoaded;
      },
    );
  }
}
