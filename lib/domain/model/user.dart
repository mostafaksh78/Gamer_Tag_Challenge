import 'package:gamer_tag/data/entity/user.dart';

class User extends UserEntity {
  final String imageAsset;

  const User(super.name, super.id) : imageAsset = "assets/profile.png";

  User.entity(UserEntity u):this(u.name,u.id);
}
