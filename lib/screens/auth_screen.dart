import 'package:provider/provider.dart';

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/http_exception.dart';
import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    print("Build() - AuthScreen");
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffFFB156).withOpacity(0.9),
                  const Color(0xffFFF7EE).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 94.0),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff1E4E5F),
                      boxShadow: [
                        const BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Text(
                      "MeShop",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Anton',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: deviceSize.width > 600 ? 2 : 1,
                  child: AuthCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1.5), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _passwordController.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("An Error Occured!"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text(
              "Okay",
              style: const TextStyle(color: const Color(0xff021639)),
            ),
            onPressed: () {
              Navigator.of(context).pop(_authMode);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() => _isLoading = true);
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = "Authentication failed";
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "This email is already in use";
      } else if (error.toString().contains('INVALID_EMAIl')) {
        errorMessage = "This is not a valid email";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = "This password is too weak";
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "Could not find a user with this email";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "This password is invalid";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          "Could not authenticate you..Please try again later...";
      _showErrorDialog(errorMessage);
    }
    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() => _authMode = AuthMode.Signup);
      _controller.forward();
    } else {
      setState(() => _authMode = AuthMode.Login);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build() - AuthCard");
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width > 800 ? 500 : double.infinity,
      padding: const EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: _authMode == AuthMode.Signup ? 320 : 260,
          // height: _heightAnimation.value.height,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.Signup ? 320 : 260),
          // constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
          width: deviceSize.width * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter an email';
                      else if (!value.contains('@')) return 'Invalid email!';
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        color: const Color(0xff1E4E5F),
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: !_showPassword,
                    controller: _passwordController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter a password';
                      else if (value.length < 5)
                        return 'Password is too short!';
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  // if (_authMode == AuthMode.Signup)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                    ),
                    curve: Curves.easeIn,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password'),
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              // ignore: missing_return
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xff1E4E5F)),
                    )
                  else
                    ElevatedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        primary: Theme.of(context).primaryColor,
                        textStyle: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.button.color,
                        ),
                      ),
                    ),
                  TextButton(
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: _switchAuthMode,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
