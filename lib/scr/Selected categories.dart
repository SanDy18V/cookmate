import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../controller/authentic controllers.dart';
import '../modulew/catagory_recipie_data.dart';

class Categoriesindex extends StatefulWidget {
  const Categoriesindex({Key? key}) : super(key: key);

  @override
  State<Categoriesindex> createState() => _CategoriesindexState();
}

class _CategoriesindexState extends State<Categoriesindex> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firebasecontroller = Get.find<Authentication>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments.toString(),style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24)),
        ),
        body: Container(
          child: StreamBuilder(
            stream: firestore.collection(Get.arguments.toString()).snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final catgorydocs = streamSnapshot.data?.docs;
             return GridView.builder(
                 gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10),
                itemCount: catgorydocs?.length,
                shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (ctx,int index){
                    return InkWell(
                      onTap: (){
                        var collectid = Get.arguments.toString();
                        print(collectid);
                        var catdocmentid =catgorydocs?[index].id;
                        print(catdocmentid);
                        Get.to(CategoryRescipie(),arguments: [collectid,catdocmentid]);
                      },
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            SizedBox(height: 5,),
                            CircleAvatar(
                              radius: 70,
                               backgroundImage: NetworkImage(catgorydocs?[index]["recipe_img"]),
                            ),
                           SizedBox(height: 15,),
                            Text(catgorydocs?[index]["name"],style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,))

                          ],
                        ),
                      ),
                    );
              });
            },
          ),
        ));
  }
}
class CategoryRescipie extends StatefulWidget {
  const CategoryRescipie({Key? key}) : super(key: key);

  @override
  State<CategoryRescipie> createState() => _CategoryRescipieState();
}

class _CategoryRescipieState extends State<CategoryRescipie> {
  final firebasecontroller = Get.find<Authentication>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isLoading = true;
  bool _isliked = false;
  CatagoryRecipie catagoryRecipie =CatagoryRecipie();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      firestore.collection(Get.arguments[0]).doc(Get.arguments[1]).get().then((value)async{
        catagoryRecipie = CatagoryRecipie.fromMap(value.data()as Map<String,dynamic>);

        setState(() {
          _isLoading = false;
          // Use the fetched data here
        });
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(catagoryRecipie.name ?? "",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24),),
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
                            image: NetworkImage(catagoryRecipie.recipeImg.toString()),fit: BoxFit.fitWidth
                        )
                    ),
                    child: Stack(
                      children: [
                        Positioned(right: 2,
                            child: IconButton(onPressed: (){
                              _isliked = true;
                              setState(() {
                                var favoriteindex= catagoryRecipie.name;
                                var favoriteimage =catagoryRecipie.recipeImg;
                                print(favoriteindex);
                                firebasecontroller.favlist?.add(favoriteindex!);
                                firebasecontroller.favlistimg?.add(favoriteimage!);

                              });
                            }, icon:  _isliked?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite,color: Colors.white70,)),)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(catagoryRecipie.name ?? "",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 24),),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.timer),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Cooking Time :${catagoryRecipie.cookTime.toString()}",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
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
                child: Text(catagoryRecipie.about.toString()),
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
                      itemCount: catagoryRecipie.ingredients!.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx,int index){
                        return Column(
                          children: [
                            ListTile(
                              title:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text( catagoryRecipie.ingredients![index],),
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
                    itemCount: catagoryRecipie.instructions!.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx,int index){
                      return Column(
                        children: [
                          ListTile(
                            title:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(catagoryRecipie.instructions![index],),
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
    );
  }
}
