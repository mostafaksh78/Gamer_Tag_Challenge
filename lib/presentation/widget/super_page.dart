import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag/presentation/user_bloc/bloc.dart';
import 'package:gamer_tag/presentation/user_bloc/event/event.dart';
import 'package:gamer_tag/presentation/user_bloc/state/state.dart';
import 'package:gamer_tag/presentation/widget/chat_page.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:flutter/material.dart' as mat;
class SuperPage extends StatelessWidget {
  const SuperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc,UserState>(
              builder: (context, state) {
                switch (state) {
                  case LoadingUsers state:
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  case ShowUser state:
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<UserBloc>(context)
                            .add(UserChangeEvent());
                      },
                      child: Column(
                        children: [
                          mat.CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(
                                state.user.imageAsset), // Replace with actual profile image URL
                          ),
                          Text(state.user.name)
                        ],
                      ),
                    );
                  default:
                    return const Center(child: Text("Unknown state"),);
                }
              },
            ),
          ],
        ),
        avatarModel: AvatarModel( icon: CupertinoIcons.info_circle,avatarIsVisible: true,),
        appBarType: AppBarType.NormalNavbarWithoutSearch,
        slivers: [
          const SliverToBoxAdapter(child: ChatPage(),),
        ],
      ),
    );
  }
}
