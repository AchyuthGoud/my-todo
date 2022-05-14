import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/bloc/auth/authentication_cubit.dart';
import 'package:todo_app/bloc/connectivity/connectivity_cubit.dart';
import 'package:todo_app/presentation/widgets/mybutton.dart';
import 'package:todo_app/presentation/widgets/myindicator.dart';
import 'package:todo_app/presentation/widgets/mysnackbar.dart';
import 'package:todo_app/shared/constants/strings.dart';
import 'package:todo_app/shared/styles/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authcubit = BlocProvider.of(context);
    ConnectivityCubit connectivitycubit = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            Navigator.pushReplacementNamed(context, homepage);
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoadingState) {
            return const MyCircularIndicator();
          }

          if (state is! AuthenticationSuccessState) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'TASK MANAGER ',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(letterSpacing: 3),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    MyButton(
                      color: Colors.lightBlueAccent,
                      width: 80.w,
                      title: 'Login',
                      func: () {
                        Navigator.pushNamed(context, loginpage);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyButton(
                      color: Colors.lightBlueAccent,
                      width: 80.w,
                      title: 'Sign Up',
                      func: () {
                        Navigator.pushNamed(context, signuppage);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // _myOutlinedButton(context, authcubit, connectivitycubit),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Container _myOutlinedButton(BuildContext context, AuthenticationCubit cubit,
      ConnectivityCubit connectivityCubit) {
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Colors.deepPurple, width: 2)),
      child: MaterialButton(
        onPressed: () {
          if (connectivityCubit.state is ConnectivityOnlineState) {
            cubit.signinanonym();
          } else {
            MySnackBar.error(
                message: 'Please Check Your Internet Conection',
                color: Colors.lightBlueAccent,
                context: context);
          }
        }
      ),
    );
  }
}
