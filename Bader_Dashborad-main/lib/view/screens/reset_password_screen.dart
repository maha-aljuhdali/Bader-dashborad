import 'package:bader_dashboard/view_model/auth_cubit/auth_cubit.dart';
import 'package:bader_dashboard/view_model/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/display_dialogs.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.getInstance(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is SendPasswordResetEmailSuccessState) {
        showSnackBar(
            seconds: 25,
            context: context,
            message:
                "تم إرسال رسالة للبريد الإلكتروني لإعادة تعيين كلمة المرور  ",
            backgroundColor: Colors.green);
        Navigator.pop(context);
      }
      if (state is SendPasswordResetEmailFailureState) {
        showSnackBar(
            context: context,
            message: "حدث خطأ أثناء عملية المصادقة مع البريد الالكتروني",
            backgroundColor: Colors.red);
      }
    }, builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
              body: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 238, 245),
              ),
            ),
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text('لاعادة تعيين كلمة المرور'),
                          Text(
                            " الرجاء ادخال البريد الالكتروني",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          _textField(controller: _emailController),
                          SizedBox(
                            height: 22.5.h,
                          ),
                          MaterialButton(
                            color: const Color(0xFF3E5788),
                            height: 45.h,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            minWidth: 350,
                            textColor: Colors.white,
                            child: Text(
                              "تأكيد",
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_emailController.text.isNotEmpty) {
                                if (_emailController.text.trim() ==
                                    AuthCubit.getInstance(context)
                                        .adminModel!
                                        .email!
                                        .trim()) {
                                  cubit.sendPasswordResetToEmail(
                                      email: _emailController.text.trim());
                                } else {
                                  showSnackBar(
                                      context: context,
                                      message:
                                          "غير مصرح لهذا البريد الإلكتروني بالدخول",
                                      backgroundColor: Colors.red);
                                }
                              } else {
                                showSnackBar(
                                    context: context,
                                    message: "الرجاء إدخال البريد الإلكتروني",
                                    backgroundColor: Colors.red);
                              }
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                  child: Icon(Icons.keyboard_backspace_outlined,
                                      size: 20, color: Colors.black54)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ])),
        ),
      );
    });
  }
}

Widget _textField({required TextEditingController controller, bool? isSecure}) {
  return SizedBox(
    width: 340,
    height: 45.h,
    child: TextFormField(
      controller: controller,
      obscureText: isSecure ?? false,
      decoration: InputDecoration(
        hintText: 'البريد الالكتروني',
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
  );
}
