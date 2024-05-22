import 'package:fesarmatch/global.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavSFR_screen extends StatefulWidget {
  const FavSFR_screen({super.key});

  @override
  State<FavSFR_screen> createState() => _FavSFR_screenState();
}

class _FavSFR_screenState extends State<FavSFR_screen> {

  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoritesList = [];

  getFavoriteListKeys() async
  {
    if (isFavoriteSentClicked)
    {
      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID.toString()).collection("favoriteSent")
          .get();

      for (int i = 0; i < favoriteSentDocument.docs.length; i++) {
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      print("Lista Favoritos Enviados:" + favoriteSentList.toString());
      getKeysDataFromUsersCollection(favoriteSentList);
    }


    else
    {
      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID.toString()).collection("favoriteReceived")
          .get();

      for (int i = 0; i < favoriteReceivedDocument.docs.length; i++) {
        favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
      }
      print("Lista Favoritos Recibidos :" + favoriteReceivedList.toString());

      getKeysDataFromUsersCollection(favoriteReceivedList);
    }
  }
  getKeysDataFromUsersCollection(List<String>keysList) async
  {
    var allUsersDocument = await FirebaseFirestore.instance.collection("Usuarios").get();

    for(int i=0; i<allUsersDocument.docs.length; i++)
    {
      for(int k=0; k<keysList.length; k++)
      {
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k])
        {
          favoritesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favoritesList;
    });
    print("Lista de Favoritos:" + favoritesList.toString());

  }

  @override

  void initState() {
    // TODO: implement initState
    super.initState();

    getFavoriteListKeys();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: ()
              {
                favoriteSentList.clear();
                favoritesList = [];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoritesList.clear();
                favoritesList = [];

                setState(() {
                  isFavoriteSentClicked = true;
                });

                getFavoriteListKeys();
              },
              child: Text(
                "Mis favoritos",
                style: TextStyle(
                  color:isFavoriteSentClicked ? Colors.white : Colors.grey,
                  fontWeight: isFavoriteSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),

            const Text(
                "      |      ",
                style: TextStyle(
                  color: Colors.grey,
                )
            ),

            TextButton(
              onPressed: ()
              {
                favoriteSentList.clear();
                favoritesList = [];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoritesList.clear();
                favoritesList = [];

                setState(() {
                  isFavoriteSentClicked = false;
                });

                getFavoriteListKeys();
              },
              child: Text(
                "Yo soy su favorito",
                style: TextStyle(
                  color:isFavoriteSentClicked ? Colors.grey : Colors.white,
                  fontWeight: isFavoriteSentClicked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),


          ],
        ),
        centerTitle: true,
      ),
      body: favoritesList.isEmpty
          ? const Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white, size:  60,),
      )
          : GridView.count(
        crossAxisCount: 2,
        padding:const EdgeInsets.all(8),
        children: List.generate(favoritesList.length, (index)
        {
          return GridTile(
              child: Padding(
                padding: const EdgeInsets.all (2.0),
                child: Card(
                  color: Colors.blue.shade200,
                  child: GestureDetector(
                    onTap: ()
                    {

                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(favoritesList[index]["imagenPerfil"],),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),

                              //Nombre y edad
                              Text(
                                favoritesList[index]["nombre"].toString() + " • " + favoritesList[index]["Edad"].toString(),
                                maxLines: 2,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.purpleAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 4,
                              ),
                              // --------- Icon y Carrera
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  Expanded(
                                    child: Text(
                                      favoritesList[index]["ciudad"].toString() + " , " + favoritesList[index]["Carrera"].toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontSize: 13,

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ),
              )
          );
        }),
      ),

    );
  }
}
