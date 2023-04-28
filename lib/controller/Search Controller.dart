import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../modulew/Search data.dart';

class Searchcontroller extends GetxController{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Searchrescpie searchrescpie =Searchrescpie();


  searchdata()async{
  firestore.collection("Search").doc("Allrescpie").get().then((value) async{
    searchrescpie = Searchrescpie.fromMap(value.data() as Map<String,dynamic>);
   print(searchrescpie.rescpiename);

  });
  }





}