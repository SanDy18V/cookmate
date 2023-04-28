import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rescpies/scr/signup.dart';

import '../controller/authentic controllers.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName =  "/scr/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firebasecontroller = Get.find<Authentication>();
  TextEditingController emaillogcontroller =TextEditingController();
  TextEditingController passwordlogcontroller =TextEditingController();
  TextEditingController forgotcontroller =TextEditingController();
  bool passwordVisible = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.11,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text("LOGIN ",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("Let's find the Recipe & start to cook ",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140,
                width: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/my4.png"),fit: BoxFit.fill
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: TextField(
                    controller: emaillogcontroller,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.mail,),
                  labelText: 'Enter your Email',

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: TextField(
                controller: passwordlogcontroller,
                style: const TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Enter your Password',

                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),

                  ),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                            () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                          child: SizedBox(
                               height: 500,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Forgot Password?",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Please Enter your Email, we will send verify mail ",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage("assets/img/my5.png"),fit: BoxFit.contain
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: TextFormField(
                                      controller: forgotcontroller,

                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your Email',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: ElevatedButton(
                                        onPressed: (){
                                                 if(RegExp(
                                                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(forgotcontroller.text)){
                                                   if (kDebugMode) {
                                                     print("ok");
                                                   }
                                                 }
                                              if(forgotcontroller.text.isNotEmpty){
                                                firebasecontroller.forgotpassword(forgotcontroller.text);
                                              }
                                        }, child: Text("Next",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }, child: const Text("Forgot Password ?",style: TextStyle(fontWeight: FontWeight.bold),))
              ],
            ),
            // Row(
            //   children: [
            //     Checkbox(
            //       value: _isChecked,
            //       onChanged: (value) {
            //         setState(
            //               () {
            //             _isChecked = value!;
            //           },
            //         );
            //       },
            //       activeColor: Colors.green,
            //       checkColor: Colors.white,
            //     ),
            //     const Text(
            //       "I agree the terms and condition",
            //       style: TextStyle(
            //
            //           fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                  onPressed: (){
                   if(emaillogcontroller.text.isNotEmpty && passwordlogcontroller.text.isNotEmpty){
                     firebasecontroller.login(emaillogcontroller.text, passwordlogcontroller.text);
                   }else{
                     Get.snackbar("Invalid Credentials","Please enter Mandatory fields",
                         icon: const Icon(Icons.error, color: Colors.red
                         ),
                         snackPosition: SnackPosition.TOP);
                   }
                  }, child: Text("Login",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: null,
                    decoration: const BoxDecoration(
                        border:
                        Border(bottom: BorderSide())),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "OR",
                  style: TextStyle(
                       fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: null,
                    decoration: const BoxDecoration(
                        border:
                        Border(bottom: BorderSide())),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't you have any Account ?",style: TextStyle(fontWeight: FontWeight.bold),),
                TextButton(
                  onPressed: () {
                     Get.offAllNamed(Signup.routeName);
                  },
                  child:  Text(
                    "Signup",
                    style:Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
