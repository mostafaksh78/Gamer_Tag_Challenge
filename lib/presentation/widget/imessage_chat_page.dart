import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/use_case/use_case.dart';
import 'package:gamer_tag/presentation/input_bloc/bloc.dart';
import 'package:gamer_tag/presentation/message_bloc/bloc.dart';
import 'package:gamer_tag/presentation/message_bloc/event/event.dart';
import 'package:gamer_tag/presentation/message_bloc/state/state.dart';
import 'package:gamer_tag/presentation/user_bloc/bloc.dart';
import 'package:gamer_tag/presentation/user_bloc/event/event.dart';
import 'package:gamer_tag/presentation/user_bloc/state/state.dart';
import 'package:gamer_tag/presentation/widget/app_bar.dart';
import 'package:gamer_tag/presentation/widget/chat_bubble.dart';
import 'package:gamer_tag/presentation/widget/chat_page.dart';
import 'package:gamer_tag/presentation/widget/date_bubble.dart';
import 'package:gamer_tag/presentation/widget/new_chat_page.dart';
import 'package:get_it/get_it.dart';

import 'imessage_input_bar.dart';

class IMessageChatPage extends StatelessWidget {
  const IMessageChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   // padding:EdgeInsetsDirectional.s,
      //   leading: CupertinoButton(
      //     padding: EdgeInsets.zero,
      //     child: const Icon(CupertinoIcons.back, size: 24),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   middle: const SafeArea(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         mat.CircleAvatar(
      //           radius: 24,
      //           backgroundImage: AssetImage(
      //               "assets/profile.png"), // Replace with actual profile image URL
      //         ),
      //       ],
      //     ),
      //   ),
      //   trailing: CupertinoButton(
      //     padding: EdgeInsets.zero,
      //     child: const Icon(CupertinoIcons.info_circle, size: 24),
      //     onPressed: () {
      //       // Info button action
      //     },
      //   ),
      // ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: const SafeArea(
          child: Column(
            children: [
              // CupertinoNavigationBar(
              //   leading: CupertinoButton(
              //     padding: EdgeInsets.zero,
              //     child: const Icon(CupertinoIcons.back, size: 24),
              //     onPressed: () {},
              //   ),
              //   middle: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       BlocBuilder<UserBloc,UserState>(
              //         builder: (context, state) {
              //           switch (state) {
              //             case LoadingUsers state:
              //               return const Center(
              //                 child: CupertinoActivityIndicator(),
              //               );
              //             case ShowUser state:
              //               return GestureDetector(
              //                 onTap: () {
              //                   BlocProvider.of<UserBloc>(context)
              //                       .add(UserChangeEvent());
              //                 },
              //                 child: Column(
              //                   children: [
              //                     mat.CircleAvatar(
              //                       radius: 24,
              //                       backgroundImage: AssetImage(
              //                           state.user.imageAsset), // Replace with actual profile image URL
              //                     ),
              //                     Text(state.user.name)
              //                   ],
              //                 ),
              //               );
              //             default:
              //               return const Center(child: Text("Unknown state"),);
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              //   trailing: CupertinoButton(
              //     padding: EdgeInsets.zero,
              //     child: const Icon(CupertinoIcons.info_circle, size: 24),
              //     onPressed: () {
              //       // Info button action
              //     },
              //   ),
              // ),
              AppBar(),
              Expanded(
                child: NewChatPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



