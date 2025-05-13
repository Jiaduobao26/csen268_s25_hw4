import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/authentication_bloc.dart';
import '../widgets/button_widget.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface, 
            fontWeight: FontWeight.w400,
          ),
      ),

      ),
      body: Center(
        child: ButtonWidget(
          onPressed: () {
            context.read<AuthenticationBloc>().add(AuthenticationLoginRequested());
          },
          text: 'Login'
        )
      ),
    );
  }
}
