import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/authentic controllers.dart';
import '../modulew/Single User Data.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final firebasecontroller = Get.find<Authentication>();
  final TextEditingController _editnamecontroller = TextEditingController();
  final TextEditingController _editmail = TextEditingController();
  final TextEditingController _gendercontroller =TextEditingController();
  User? user =  FirebaseAuth.instance.currentUser;
  Userdata loggedUser= Userdata();
   bool _isloaded= true;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = Userdata.fromMap(value.data());
      setState(() {
          _isloaded= false;
      });
    });


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:Text("Profile",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: (){
            firebasecontroller.logoutshowAlertDialog(context);
          }, icon:const Icon(Icons.logout_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child:_isloaded ?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/1,),
            Center(child: CircularProgressIndicator(),),
          ],
        ) :Column(

          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Stack(
                          children: [
                             CircleAvatar(
                              radius:70,
                                 backgroundImage: loggedUser.profile_pic_url != null ? NetworkImage(loggedUser.profile_pic_url.toString()):const NetworkImage("https://i.pinimg.com/originals/cc/18/9c/cc189ca9c6dc75dcc530bf9bc1c32fcc.png")
                            ),
                            Positioned(
                                right: 3,
                                bottom: 2,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "Chat Box",
                                        middleText: "Please select",
                                        radius: 10,
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                 firebasecontroller.uploadpicgallery();
                                                Get.back();

                                              },
                                              child: Column(
                                                children: const [
                                                  Icon(Icons.photo),
                                                  Text("Gallery"),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                firebasecontroller.uploadpiccamera();
                                                Get.back();

                                              },
                                              child: Column(
                                                children: const [
                                                  Icon(Icons.camera_alt),
                                                  Text("Camera"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.camera_alt,color: Colors.white,),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(Icons.account_circle),
                            title: const Text(
                              'Name',
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom:
                                              MediaQuery.of(context).viewInsets.bottom),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 50, top: 20),
                                                    child: Text(
                                                      "Enter Your Name",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50, right: 50),
                                                child: TextField(
                                                  controller: _editnamecontroller,
                                                  keyboardType: TextInputType.name,
                                                  decoration:  InputDecoration(
                                                    hintText:loggedUser.name ??"".toString(),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 200),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text("cancel")),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (kDebugMode) {
                                                         firebasecontroller.updatename(_editnamecontroller.text);
                                                         FirebaseFirestore.instance
                                                             .collection("users")
                                                             .doc(user!.uid)
                                                             .get()
                                                             .then((value) {
                                                           loggedUser = Userdata.fromMap(value.data());
                                                           setState(() {
                                                             print("finissssssssssh");
                                                             _isloaded= false;
                                                           });
                                                         });

                                                        }
                                                        Get.back();
                                                      },
                                                      child: const Text("Save")),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: loggedUser.name ??"",
                                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                    border: InputBorder.none),

                                readOnly: true,
                              ),
                            ),
                            selected: true,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 75),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(Icons.mail),
                            title: const Text(
                              'Mail',
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: loggedUser.email ??"",
                                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                    border: InputBorder.none),

                                controller: _editmail,
                                readOnly: true,
                              ),
                            ),
                            selected: true,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 75),
                          child: Divider(),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(Icons.groups),
                            title: const Text(
                              'Gender',
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextField(
                                decoration:  InputDecoration(
                                    labelText: loggedUser.gender ??"",
                                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                    border: InputBorder.none),
                                controller: _gendercontroller,
                                readOnly: true,
                              ),
                            ),
                            selected: true,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
