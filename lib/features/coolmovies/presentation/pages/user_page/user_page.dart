import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('User Data', style: bigTitleTextStyle),
                const SizedBox(height: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: backgroundCard,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.user.name,
                              textAlign: TextAlign.center,
                              style: bigTitleTextStyle),
                          const SizedBox(height: 5.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'ID: ',
                                    style: titleTextStyle,
                                  ),
                                  TextSpan(
                                    text: state.user.id,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(LogOutUserEvent());
                    },
                    child: const Text(
                      'Sign out',
                      style: titleTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is UserNotAuthenticated) {
          return FlutterLogin(
            logo: const AssetImage('assets/images/coolmovies_splash.png'),
            onLogin: (LoginData loginData) {
              BlocProvider.of<UserBloc>(context)
                  .add(LogInUserEvent(loginData: loginData));
              return null;
            },
            onSignup: (SignupData signupData) {
              BlocProvider.of<UserBloc>(context)
                  .add(SignUpUserEvent(signupData: signupData));
              return null;
            },
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            theme: LoginTheme(
              primaryColor: backgroundColor,
            ),
            hideForgotPasswordButton: true,
            userType: LoginUserType.name,
            savedPassword: 'user_password',
            userValidator: (value) {
              if (value?.isEmpty ?? true) {
                return "User name required";
              } else {
                return null;
              }
            },
            onRecoverPassword: (_) => Future(() => null),
          );
        }
        return Container();
      },
    );
  }
}
