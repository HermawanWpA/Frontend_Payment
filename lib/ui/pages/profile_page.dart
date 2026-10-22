import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylatter/blocs/auth/auth_bloc.dart';
import 'package:paylatter/shared/helper.dart';
import 'package:paylatter/shared/theme.dart';
import 'package:paylatter/ui/widget/buttons.dart';
import 'package:paylatter/ui/widget/profile_menu_item.dart';
import 'package:quickalert/quickalert.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/sign-in',
              (route) => false,
            );
            showCustomSnackbar(context, 'Berhasil, Logout');
          }

          if (state is AuthFailed) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: '',
              text: state.e,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthSuccess) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: state.data.profilePicture == null
                                ? const AssetImage('assets/img_profile.png')
                                : NetworkImage(
                                    state.data.profilePicture!,
                                  ) as ImageProvider,
                          ),
                        ),
                        child: state.data.verified == 1
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor),
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: greenColor,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.data.name.toString(),
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: medium),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ProfileMenuItem(
                          iconUrl: 'assets/ic_edit_profile.png',
                          title: 'Edit Profile',
                          onTap: () async {
                            // ignore: use_build_context_synchronously
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/profile-edit');
                            }
                          }),
                      ProfileMenuItem(
                          iconUrl: 'assets/ic_pin.png',
                          title: 'My Pin',
                          onTap: () async {
                            // ignore: use_build_context_synchronously
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/profile-edit-pin');
                            }
                          }),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_wallet.png',
                        title: 'Wallet Settings',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_my_rewards.png',
                        title: 'My Rewards',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_help.png',
                        title: 'Help Center',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_logout.png',
                        title: 'Logout',
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 87,
                ),
                CustomTextButton(
                  title: 'Report a problem',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
