import 'package:bader_dashboard/shared/components/colors.dart';
import 'package:bader_dashboard/view/screens/reset_password_screen.dart';
import 'package:bader_dashboard/view_model/auth_cubit/auth_cubit.dart';
import 'package:bader_dashboard/view_model/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/display_dialogs.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.getInstance(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is LoginSuccessState) {
        showSnackBar(
            context: context,
            message: "تم تسجيل الدخول بنجاح",
            backgroundColor: Colors.green,
            seconds: 2);
        Navigator.pushReplacementNamed(context, 'dashboard_screen');
      }
      if (state is FailedToLoginState) {
        showSnackBar(
            context: context,
            message: state.message,
            backgroundColor: Colors.red,
            seconds: 2);
      }
    }, builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
            child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 222, 238, 245),
                ),
              ),
              Row(
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    height: 600,
                    width: 450,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/LOGO.jpg",
                          height: 100,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " بادر",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "نظام ادارة الأندية الطلابية بجامعة طيبة",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          "البريد الإلكتروني",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        _textField(controller: _emailController),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "كلمة المرور",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        _textField(
                            controller: _passwordController, isSecure: true),
                        SizedBox(
                          height: 20.5.h,
                        ),
                        MaterialButton(
                          color: mainColor,
                          height: 45.h,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          minWidth: 300,
                          textColor: Colors.white,
                          child: Text(
                            state is LoginLoadingState
                                ? "جاري تسجيل الدخول"
                                : "تسجيل الدخول",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              cubit.login(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            } else {
                              showSnackBar(
                                  context: context,
                                  message: "الرجاء إدخال البيانات كامله",
                                  backgroundColor: Colors.red,
                                  seconds: 2);
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Todo:
                              _emailController.clear();
                              _passwordController.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen()));
                            },
                            child: Text(
                              "هل نسيت كلمة المرور ؟",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                ],
              ),
            ],
          ),
        )),
      );
    });
  }

  Widget _textField(
      {required TextEditingController controller, bool? isSecure}) {
    return SizedBox(
      width: 300,
      height: 45.h,
      child: TextFormField(
        controller: controller,
        obscureText: isSecure ?? false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
