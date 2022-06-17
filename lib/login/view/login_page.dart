import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_coda/common/app_size.dart';
import 'package:test_coda/common/validators.dart';
import 'package:test_coda/common/widgets/background_paint.dart';
import 'package:test_coda/common/widgets/coda_button.dart';
import 'package:test_coda/l10n/l10n.dart';
import 'package:test_coda/login/bloc/login_bloc.dart';
import 'package:test_coda/login/widgets/coda_text_form_field.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const ViewLogin(),
    );
  }
}

class ViewLogin extends StatefulWidget {
  const ViewLogin({super.key});

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordObscure = true;
  bool emailObscure = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.isSuccesful) {}
                return Stack(
                  children: [
                    Blur(
                      blur: 20,
                      blurColor: Colors.white.withOpacity(0.5),
                      child: Stack(
                        children: const [
                          BackgroundPaint(
                            svg: 'assets/top-right-vector.svg',
                            alignment: Alignment.topRight,
                          ),
                          BackgroundPaint(
                            svg: 'assets/center-left-vector.svg',
                            alignment: Alignment.centerLeft,
                          ),
                          BackgroundPaint(
                            svg: 'assets/bottom-center-vector.svg',
                            alignment: Alignment.bottomCenter,
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        width: width,
                        height: height,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize(context).pixels(40),
                        ),
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/login-title.png',
                                width: width * 0.8,
                              ),
                              SizedBox(height: AppSize(context).pixels(50)),
                              Text(
                                context.l10n.login,
                                style: TextStyle(
                                  letterSpacing: 2.5,
                                  color:
                                      const Color(0xff0D1111).withOpacity(0.85),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: AppSize(context).pixels(30)),
                              Form(
                                key: _formKey,
                                child: AutofillGroup(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CodaTextFormField(
                                        controller: _emailController,
                                        hintText: context.l10n.mail,
                                        validator: validateEmail,
                                        obscureText: emailObscure,
                                        onChanged: () => setState(() {
                                          emailObscure = !emailObscure;
                                        }),
                                      ),
                                      CodaTextFormField(
                                        controller: _passwordController,
                                        hintText: context.l10n.password,
                                        validator: validatePassword,
                                        obscureText: passwordObscure,
                                        onChanged: () => setState(() {
                                          passwordObscure = !passwordObscure;
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: AppSize(context).pixels(52),
                              ),
                              CodaButton(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSize(context).pixels(18),
                                ),
                                width: width * 0.8,
                                title: context.l10n.login,
                                onPressed: submit,
                              ),
                              SizedBox(
                                height: AppSize(context).pixels(125),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void submit([dynamic _]) {
    final validForm = _formKey.currentState?.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (validForm ?? false) {
      context
          .read<LoginBloc>()
          .attemptLogin(_emailController.text, _passwordController.text);
    }
  }
}
