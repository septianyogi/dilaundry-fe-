// ignore_for_file: unnecessary_import, type_literal_in_constant_pattern

import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:dilaundry/config/app_assets.dart';
import 'package:dilaundry/config/app_colors.dart';
import 'package:dilaundry/config/app_constants.dart';
import 'package:dilaundry/config/app_response.dart';
import 'package:dilaundry/config/app_session.dart';
import 'package:dilaundry/config/failure.dart';
import 'package:dilaundry/config/nav.dart';
import 'package:dilaundry/datasource/user_datasource.dart';
import 'package:dilaundry/pages/auth/register_page.dart';
import 'package:dilaundry/pages/dashboard_page.dart';
import 'package:dilaundry/providers/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  execute() {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;

    setLoginStatus(ref, 'Loading');

    UserDatasource.login(
      edtEmail.text,
      edtPassword.text,
    ).then((value) {
      String newStatus = '';
      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
            newStatus = 'Server Error';
              DInfo.toastError(newStatus);
              break;
            case NotFoundFailure:
            newStatus = 'Error Not FOund';
              DInfo.toastError(newStatus);
              break;
            case ForbiddenFailure:
            newStatus = 'You don\'t have access';
              DInfo.toastError(newStatus);
              break;
            case BadRequestFailure:
            newStatus = 'Bad request';
              DInfo.toastError(newStatus);
              break;
            case InvalidInputFailure:
            newStatus = 'Invalid input';
              AppResponse.invalidInput(context, failure.message ?? '{}');
              break;
            case UnauthorisedFailure:
            newStatus = 'Login Failed';
              DInfo.toastError(newStatus);
              break;
            default:
              newStatus = 'Request Error';
              DInfo.toastError(newStatus);
              newStatus = failure.message??'-';
              DInfo.toastError(newStatus);
              break;
          }
          setLoginStatus(ref, newStatus);
        }, 
        (result) {
          AppSession.setUser(result['data']);
          AppSession.setBearerToken(result['token']);
          DInfo.toastSuccess('Login success');
          setLoginStatus(ref, 'Success');
          Nav.replace(context, const DashboardPage());
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.bgAuth,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height /2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30,60,30,30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Text(
                        AppConstant.appName,
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: (Colors.green[900]),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10),
                                child: const Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            DView.width(10),
                            Expanded(
                              child: DInput(
                                controller: edtEmail,
                                fillColor: Colors.white70,
                                hint: 'Email',
                                radius: BorderRadius.circular(10),
                                validator: (input) =>
                                  input == '' ? "Don't empty" : null,
                              ),
                            )
                          ],
                        ),
                      ),
                      DView.height(16),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10),
                                child: const Icon(
                                  Icons.key,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            DView.width(10),
                            Expanded(
                              child: DInputPassword(
                                controller: edtPassword,
                                fillColor: Colors.white70,
                                hint: 'Password',
                                radius: BorderRadius.circular(10),
                                validator: (input) =>
                                  input == '' ? "Don't empty" : null,
                              ),
                            )
                          ],
                        ),
                      ),
                      DView.height(16),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: DButtonFlat(
                                onClick: () {
                                  Nav.push(context, const RegisterPage());
                                },
                                padding: const EdgeInsets.all(0),
                                radius: 10,
                                mainColor: Colors.white70,
                                child: const Text(
                                  'REG',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ),
                              DView.width(10),
                              Expanded(
                                child: Consumer(
                                builder: (_,wiRef, __) {
                                  String status = wiRef.watch(loginStatusProvider);
                                  if(status == 'Loading') {
                                    return DView.loadingCircle();
                                  }
                                  return ElevatedButton(
                                    onPressed: () => execute(),
                                    style: const ButtonStyle(
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                      ),
                                  );
                                }
                              ))
                          ],
                        ),
                      )
                    ],
                  ))
              ],
            ),
          )
        ],
      ),
    );
  }
}