import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rescpies/controller/authentic%20controllers.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
 static const routeName ="/scr/signup";
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
    final firebasecontroller = Get.find<Authentication>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController _controller =TextEditingController();
  var items = ['Male','Female','Others'];
  bool passwordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible =true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),

      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text("Welcome ! ",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("Please fill the details and continue with us ",style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/my2.png"),fit: BoxFit.fill
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: TextField(
                 controller: namecontroller,
                enableSuggestions: false,
                autocorrect: false,
                style: TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person,color: Colors.black,),
                  labelText: 'Enter your Name',

                  border: const OutlineInputBorder(
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
              controller: emailcontroller,
                enableSuggestions: false,
                autocorrect: false,
                style: TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail,color: Colors.black,),
                  labelText: 'Enter your Email',

                  border: const OutlineInputBorder(
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
                controller: passwordcontroller,
                style: TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.text,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Enter your Password',

                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),

                  ),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,color: Colors.black,),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: TextField(
                controller: _controller,
                enableSuggestions: false,
                autocorrect: false,
                style: TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Select Gender",
                  suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down,color: Colors.black,),
                onSelected: (String value) {
                  _controller.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return items
                      .map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),

                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height:5,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                  onPressed: (){
                        if(emailcontroller.text.isNotEmpty&& passwordcontroller.text.isNotEmpty&& namecontroller.text.isNotEmpty && _controller.text.isNotEmpty){
                          firebasecontroller.register(emailcontroller.text, passwordcontroller.text, namecontroller.text,_controller.text);
                        }else{
                          Get.snackbar("Invalid Credentials","Please enter Mandatory fields",
                              icon: const Icon(Icons.error, color: Colors.red
                              ),
                              snackPosition: SnackPosition.TOP);
                        }

                  }, child: Text("Continue",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),),
          ],
        ),
      ),
    );
  }
}
