import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/theme/size_config.dart';
import 'package:spotify_clone/core/widgets/loading.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/view/pages/home_page.dart';
import 'package:spotify_clone/features/auth/view/pages/signup_page.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify_clone/core/widgets/custom_textfield.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, "Login Sucessfull!!");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (_) => false,
          );
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sign In..", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),

                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    CustomTextfield(hintname: "Email", controller: emailController, isObs: false),

                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    CustomTextfield(hintname: "Password", controller: passwordController, isObs: true),

                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                    AuthGradientButton(
                      text: "Sign In",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .loginUser(email: emailController.text, password: passwordController.text);
                        } else {
                          showSnackBar(context, "Missing Fields!");
                        }
                      },
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleMedium,
                          text: "Dont have a account? ",
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(color: Pallete.gradient2, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
