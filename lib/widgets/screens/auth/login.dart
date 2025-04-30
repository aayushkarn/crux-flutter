import 'package:crux/widgets/home_page.dart';
import 'package:crux/widgets/screens/auth/register.dart';
import 'package:crux/services/auth_provider.dart';
import 'package:crux/services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // print("Email is ${_emailController.text}");
      // print("Password is ${_passwordController.text}");
      // final sucess = await AuthService().login(
      //   _emailController.text.trim(),
      //   _passwordController.text.trim(),
      // );
      // if (sucess) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomePage()),
      //     (route) => false,
      //   );
      // } else {
      //   ScaffoldMessenger.of(
      //     context,
      //   ).showSnackBar(SnackBar(content: Text("Invalid credentials")));
      // }
      final authProvider = context.read<AuthProvider>();
      try {
        bool success = await authProvider.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (success) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      print(_formKey.currentState!.validate());
    }
  }

  void _test() async {
    print(await getAccessToken());
  }

  @override
  Widget build(BuildContext context) {
    _test();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("crux"),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome back you've been missed! 😃 ",
                              style: TextStyle(
                                fontFamily: 'public_sans',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              obscureText: _obscure,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscure = !_obscure;
                                    });
                                  },
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),

                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return "Password must be atleast 6 characters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submit,
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontFamily: 'public_sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                              child: Text(
                                "New to crux? Signup here",
                                // selectionColor: Colors.grey,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
