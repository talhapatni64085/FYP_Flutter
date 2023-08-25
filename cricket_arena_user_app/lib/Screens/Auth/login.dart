import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/Screens/Auth/signUp.dart';
import 'package:user_app/Screens/adminDashboard.dart';
import 'package:user_app/Screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // for password visible or not
  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
  }
  // for password visible or not

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    //password field
    final passwordField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: !_passwordVisible,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(this.context).primaryColor,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 2),
          )
        ]),
        child: MaterialButton(
          onPressed: () {
            signIn();
          },
          minWidth: double.infinity,
          color: Color.fromARGB(214, 102, 50, 98),
          height: 50,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
        leading: Icon(
          Icons.arrow_back,
          color: Color.fromARGB(0, 102, 50, 98),
        ),
        title: Center(child: Text('Cricket Arena')),
        actions: [
          Icon(Icons.arrow_back_ios_new_sharp, color: Color.fromARGB(0, 102, 50, 98)),
          Icon(Icons.arrow_back_ios_new_sharp, color: Color.fromARGB(0, 102, 50, 98)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: <Widget>[Container(
                  // padding: EdgeInsets.only(top: 10),
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/calogo4.png"),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.02,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.01,
                        ),
                        Text(
                          "Login to your account",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                    emailField,
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                    passwordField,
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                    loginButton,
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        InkWell(
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                        )
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // login function
  Future signIn() async {
    try {
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == '123456789') {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdminDashboard()));
      } else {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", emailController.text);
      prefs.setString("pass", passwordController.text);
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()));}
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(e.code);
    }
  }
}
