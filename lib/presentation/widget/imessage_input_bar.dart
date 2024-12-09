import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_tag/presentation/input_bloc/bloc.dart';
import 'package:gamer_tag/presentation/input_bloc/event/event.dart';
import 'package:gamer_tag/presentation/input_bloc/state/state.dart';

class IMessageInputBar extends StatefulWidget {
  const IMessageInputBar({super.key});

  @override
  State<IMessageInputBar> createState() => _IMessageInputBarState();
}

class _IMessageInputBarState extends State<IMessageInputBar> {
  late TextEditingController controller;
  @override
  void initState() {
    controller= TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: BlocBuilder<InputBloc, InputState>(
          builder: (BuildContext context, InputState state) {
            switch (state) {
              case Show state:
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TimerWidget(
                      status: state.timer,
                    ),
                    Expanded(
                      child: CupertinoTextField(
                        onSubmitted: (value) {
                          BlocProvider.of<InputBloc>(context).add(SubmitEvent(controller.text, state.timer));
                        },
                        placeholder: "iMessage",
                        controller: controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        suffixMode: OverlayVisibilityMode.always,

                        suffix: GestureDetector(
                          onTap: () {
                            BlocProvider.of<InputBloc>(context).add(SubmitEvent(controller.text, state.timer));
                          },
                          child: SizedBox(
                            width: 48,
                            height: 32,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: CupertinoTheme
                                      .of(context)
                                      .primaryColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                CupertinoIcons.arrow_up,
                                size: 24,
                                color: CupertinoTheme
                                    .of(context)
                                    .primaryContrastingColor,
                              ),
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          border: Border.all(
                              color: CupertinoColors.inactiveGray),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                );
                break;
              default:
                return Center(child: Text("Unknown State"),);
            }
          },
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final bool status;

  const TimerWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: SvgPicture.asset(
          status ? "assets/clock_active.svg" : "assets/clock_deactive.svg"),
      onPressed: () {
        BlocProvider.of<InputBloc>(context).add(TimerToggle());
      },
    );
  }
}
