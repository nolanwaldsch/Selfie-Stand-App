import 'package:flutter/material.dart';


enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
      String email,
      void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
      String email,
      void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
      String email,
      String displayName,
      String password,
      void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch(loginState) {


      case ApplicationLoginState.loggedOut:
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: ElevatedButton(
                onPressed: () {
                  startLoginFlow();
                },
                child: Text('Login'),
              ),
            )
          ],
        );

      case ApplicationLoginState.emailAddress:
        return EmailForm(
          callback: (email) => verifyEmail(
            email, (e) => _showErrorDialog(context, 'Invalid email', e)));

      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            SignInWithEmailAndPassword(email, password, (e) => _showErrorDialog(context, 'Failed to sign in', e));
          },
        ),

      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
              email,
              displayName,
              password,
            (e) => _showErrorDialog(context, 'Failed to create account', e));
          },
        );


        // LEFT OFF MINUTE 18:00


    }
  }
}