import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/register/register.dart';
import '../../../config/routes.dart';
import '../../../config/validator.dart';
import '../../wigdets/block_header.dart';
import '../../wigdets/custom_button.dart';
import '../../wigdets/input_field.dart';
import '../../wigdets/right_arrow_action.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late double sizeBetween;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          // on success delete navigator stack and push to home
          if (state is RegisterFinishedState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.posts,
              (Route<dynamic> route) => false,
            );
          }
          // on failure show a snackbar
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          // // show loading screen while processing
          // if (state is RegisterProcessingState) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return SingleChildScrollView(
            child: Container(
              height: height * 0.9,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    OpenFlutterBlockHeader(title: 'Sign up', width: width),
                    SizedBox(
                      height: sizeBetween,
                    ),
                    CustomTextFormField(
                      controller: firstNameController,
                      hint: 'Fist Name',
                      validator: (val) => Validator.valueExists(val!),
                    ),
                    CustomTextFormField(
                      controller: lastNameController,
                      hint: 'Last Name',
                      validator: (val) => Validator.valueExists(val!),
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      hint: 'Email',
                      validator: (val) => Validator.validateEmail(val!),
                      keyboard: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      hint: 'Password',
                      validator: (val) => Validator.passwordCorrect(val!),
                      keyboard: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    OpenFlutterRightArrow(
                      'Already have an account',
                      onClick: _showSignInScreen,
                    ),
                    const SizedBox(height: 16),
                    state is RegisterProcessingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: 'SIGN UP', onPressed: _validateAndSend),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSignInScreen() {
    Navigator.of(context).pushNamed(Routes.login);
  }

  void _validateAndSend() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    context.read<RegisterBloc>().add(
          RegisterPressed(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }
}
