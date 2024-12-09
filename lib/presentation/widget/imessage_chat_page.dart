import 'package:flutter/cupertino.dart';
import 'package:gamer_tag/presentation/widget/app_bar.dart';
import 'package:gamer_tag/presentation/widget/new_chat_page.dart';


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



