import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double height =10;
  bool obsecure = true;
  var formKey =GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                         prefixIcon: Icon(
                           Icons.email,
                         ),
                        label: Text('Email'),
                      ),
                      validator: (value) {
                        if (value! .isEmpty) {
                          return ('Email must not be empty');
                        }
                          return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obsecure,
                      decoration:  InputDecoration(
                        border:const OutlineInputBorder(),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecure =! obsecure;

                            });
                          },
                         icon:const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                        label: const Text('Password'),

                      ),
                      validator: (value) {
                        if (value! .isEmpty) {
                          return('password must not be empty');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if(formKey.currentState!.validate())
                          {
                            print(emailController.text);
                            print(passwordController.text);
                          }

                      },
                      minWidth: double.infinity,
                      height: 60,
                      color: Colors.blue,
                      child: Text('login'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white
                      )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        TextButton(
                            onPressed: () {},
                            child: Text('Register now')),
                      ],
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
