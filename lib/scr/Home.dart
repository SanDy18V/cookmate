


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:rescpies/scr/Selected%20categories.dart';



import '../controller/authentic controllers.dart';
import '../modulew/Recipie data.dart';
import '../modulew/Single User Data.dart';

import '../shared_pref.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firebasecontroller = Get.find<Authentication>();
  Userdata loggedUser= Userdata();
  User? user =  FirebaseAuth.instance.currentUser;
  Rescpiedata rescpiedata = Rescpiedata();
  bool _isloadingst = true;

  @override
  void initState() {
    // firebasecontroller.fetchsingleuserdata();

    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = Userdata.fromMap(value.data());
      setState(() {
        firebasecontroller.fetchsingleuserdata();
         _isloadingst = false;
      });
    });
  }
  List categories = ['Breakfast','Lunch','Dinner','Dessert','snacks'];
  List categoriesimg= ['assets/img/cb.png','assets/img/cl.png','assets/img/cd.png','assets/img/cdes.png','assets/img/csnack.png'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Row(
                children: [
                  Text("Hello ,",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                  Text(loggedUser.name ??"",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Text("What would you Like\n to Cook Today ?",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                loggedUser.profile_pic_url != null ?
                NetworkImage(loggedUser.profile_pic_url.toString())
                     :const NetworkImage("https://i.pinimg.com/originals/cc/18/9c/cc189ca9c6dc75dcc530bf9bc1c32fcc.png"),
           radius: 30,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Categories",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                     itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (ctx,index){
                       return Row(
                         children: [
                           const SizedBox(width: 10,),
                           InkWell(
                             onTap:(){
                               var categorieindex = index+1;
                               var categoriename = categories[index];
                               print(categoriename);
                               print("Selected${categorieindex}");
                               Get.to(Categoriesindex(),arguments: categoriename);
                             },
                             child: Card(
                               elevation:4,
                               child: Container(
                                 decoration:BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                 ),
                                 child: Column(
                                   children: [
                                     Expanded(
                                       child: Container(
                                         height:50,
                                         width: 80,
                                         decoration: BoxDecoration(
                                         image: DecorationImage(
                                           image: AssetImage(categoriesimg[index]),fit: BoxFit.contain
                                         )
                                       ),),
                                     ),
                                     Text(categories[index]),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           const SizedBox(width: 10,)
                         ],
                       );
                      }),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Popular Recipies",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24),),
                  ),

                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Based on your preferences",style: Theme.of(context).textTheme.labelLarge,),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Expanded(
                child: _isloadingst ? Center(child: CircularProgressIndicator(),):StreamBuilder(stream:firestore.collection('Top picks').snapshots(),
                   builder: (ctx, streamSnapshot){
                     if(streamSnapshot.connectionState == ConnectionState.waiting){
                       return const Center(child: CircularProgressIndicator(),);
                     }
                     final documents = streamSnapshot.data?.docs;
                     return StaggeredGridView.countBuilder(
                       crossAxisCount: 2,
                       itemCount: documents?.length,
                       itemBuilder: (BuildContext context, int index) {
                         return GestureDetector(
                           onTap: (){
                              var documentid = documents[index].id;
                              Sharedpreference().setproductid(documentid.toString());
                              Get.toNamed(PopularRecipies.routeName,arguments: documentid);
                           },
                           child: Card(
                             elevation: 4,
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 image: DecorationImage(
                                   image: NetworkImage(documents![index]["recipe_img"]),fit: BoxFit.cover
                                 )
                               ),
                               child: Stack(
                                 children: [

                                   Positioned(
                                     bottom: 5,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text(documents[index]['name'],style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,color: Colors.white)),
                                       ),),
                                 ],
                               )
                             ),
                           ),
                         );
                       },
                       staggeredTileBuilder: (int index) =>
                           StaggeredTile.count(1, index.isEven ? 2 : 1),
                       mainAxisSpacing: 4.0,
                       crossAxisSpacing: 4.0,
                     );
                   }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class PopularRecipies extends StatefulWidget {
  const PopularRecipies({Key? key}) : super(key: key);
    static const routeName ="/scr/popular";
  @override
  State<PopularRecipies> createState() => _PopularRecipiesState();
}

class _PopularRecipiesState extends State<PopularRecipies> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rescpiedata rescpiedata = Rescpiedata();
  final firebasecontroller = Get.find<Authentication>();

  var productid ="";
  bool _isLoading = true;
  bool _isliked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future  documentid = Sharedpreference().getproductid();
    documentid.then((value)async{
      productid= value;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        firestore.collection("Top picks").doc(Get.arguments).get().then((value)async{
          rescpiedata =Rescpiedata.fromMap(value.data()as Map<String,dynamic>);
          print(rescpiedata.ingredients);
          setState(() {
            _isLoading = false;

            // Use the fetched data here
          });
        });
      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(rescpiedata.name ?? "",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24),),
        ),
        body: _isLoading ? Center(child: CircularProgressIndicator(),):
        SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height *0.25,
                    width: MediaQuery.of(context).size.width /1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(rescpiedata.recipeImg.toString()),fit: BoxFit.fitWidth
                        )
                    ),
                      child: Stack(
                        children: [
                          Positioned(right: 2,
                              child: IconButton(onPressed: (){
                                _isliked = true;
                              setState(() {
                               var favoriteindex= rescpiedata.name;
                               var favoriteimage = rescpiedata.recipeImg;
                               print(favoriteimage);
                               print(favoriteindex);
                                 firebasecontroller.favlist?.add(favoriteindex!);
                                 firebasecontroller.favlistimg?.add(favoriteimage!);

                              });

                              }, icon:_isliked ? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite,color: Colors.white70,)),)
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rescpiedata.name ?? "",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24),),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.timer),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Cooking Time :${rescpiedata.cookTime.toString()}",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.fastfood,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("About Rescipie",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rescpiedata.about.toString()),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add_shopping_cart),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ingredients",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Card(
                elevation: 1,
                child: Container(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: rescpiedata.ingredients!.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx,int index){
                      return Column(
                        children: [
                          ListTile(
                            title:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text( rescpiedata.ingredients![index],),
                            ),
                            leading: Icon(Icons.stars_outlined,color: Colors.blueAccent,),
                          )
                        ],
                      );
                      }),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.soup_kitchen),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Preparation",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Card(
                elevation: 4,
                child: Container(
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: rescpiedata.instructions!.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx,int index){
                        return Column(
                          children: [
                            ListTile(
                              title:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text( rescpiedata.instructions![index],),
                              ),
                              leading: Icon(Icons.note_alt_outlined,color: Colors.blueAccent,),
                            )
                          ],
                        );
                      },),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
