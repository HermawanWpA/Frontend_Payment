import 'package:flutter/material.dart';
import 'package:paylatter/models/user_model.dart';
import 'package:paylatter/shared/theme.dart';

class HomeUserItem extends StatelessWidget {
  final UserModel userSendAgain;
  const HomeUserItem({super.key, required this.userSendAgain});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 120,
      margin: const EdgeInsets.only(
        right: 17,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 13),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: userSendAgain.profilePicture == null ||
                        userSendAgain.profilePicture!.isEmpty
                    ? const AssetImage('assets/img_profile.png')
                    : NetworkImage(userSendAgain.profilePicture.toString())
                        as ImageProvider,
              ),
            ),
          ),
          Text(
            '@${userSendAgain.username}',
            style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
          ),
        ],
      ),
    );
  }
}
