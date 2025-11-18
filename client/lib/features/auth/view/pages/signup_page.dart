import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/theme/size_config.dart';
import 'package:spotify_clone/core/widgets/loading.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/auth/view/pages/login_page.dart';
import 'package:spotify_clone/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify_clone/core/widgets/custom_textfield.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading == true ));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, "Account Created Successfully!!");
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sign Up..", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),

                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                    CustomTextfield(hintname: "Name", controller: nameController, isObs: false),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    CustomTextfield(hintname: "Email", controller: emailController, isObs: false),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    CustomTextfield(hintname: "Password", controller: passwordController, isObs: true),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                    AuthGradientButton(
                      text: "Sign Up",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(
                                email: emailController.text,
                                name: nameController.text,
                                password: passwordController.text,
                              );
                        }
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleMedium,
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign In",
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
