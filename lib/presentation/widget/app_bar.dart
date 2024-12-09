import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_tag/presentation/user_bloc/bloc.dart';
import 'package:gamer_tag/presentation/user_bloc/event/event.dart';
import 'package:gamer_tag/presentation/user_bloc/state/state.dart';
import 'package:flutter/material.dart' as mat;

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGrey6,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CupertinoNavigationBarBackButton(
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<UserBloc, UserState>(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            mat.CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage(state.user
                                  .imageAsset), // Replace with actual profile image URL
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10,),
                                Text(
                                  state.user.name,
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                ),
                                const Icon(
                                  CupertinoIcons.chevron_right,
                                  color: CupertinoColors.black,
                                  size: 10,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      );
                    default:
                      return const Center(
                        child: Text("Unknown state"),
                      );
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                CupertinoButton(
                    onPressed: () {},
                    child: SvgPicture.asset("assets/video.svg")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
