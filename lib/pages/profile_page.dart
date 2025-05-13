import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/authentication_bloc.dart';
import '../widgets/button_widget.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonWidget(
          onPressed: () {
            context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
          },
          text: 'Logout',
        )
      ),
    );
  }
}