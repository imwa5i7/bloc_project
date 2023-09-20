import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/login/login.dart';
import '../../../config/routes.dart';
import '../../../config/validator.dart';
import '../../wigdets/block_header.dart';
import '../../wigdets/custom_button.dart';
import '../../wigdets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // on success delete navigator stack and push to home
          if (state is LoginFinishedState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.posts,
              (Route<dynamic> route) => false,
            );
          }
          // on failure show a snackbar
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          // show loading screen while processing
          // if (state is LoginProcessingState) {
          //   return Center(
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
                    OpenFlutterBlockHeader(title: 'Sign in', width: width),
                    SizedBox(
                      height: sizeBetween,
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
                      validator: (val) => Validator.passwordCorrect(val),
                      keyboard: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    state is LoginProcessingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: 'LOGIN', onPressed: _validateAndSend),
                    SizedBox(
                      height: sizeBetween * 2,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.register),
                        child: Text('Or sign with new account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _validateAndSend() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    context.read<LoginBloc>().add(
          LoginPressed(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }
}
