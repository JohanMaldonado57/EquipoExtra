import 'package:fesarmatch/global.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LikeSLR_screen extends StatefulWidget {
  const LikeSLR_screen({super.key});

  @override
  State<LikeSLR_screen> createState() => _LikeSLR_screenState();
}

class _LikeSLR_screenState extends State<LikeSLR_screen> {

  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likeList = [];

  getLikesListKeys() async
  {
    if (isLikeSentClicked)
    {
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID.toString()).collection("likeSent")
          .get();

      for (int i = 0; i < likeSentDocument.docs.length; i++) {
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      print("Lista Likes Enviados:" + likeSentList.toString());
      getKeysDataFromUsersCollection(likeSentList);
    }


    else
    {
      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID.toString()).collection("likeReceived")
          .get();

      for (int i = 0; i < likeReceivedDocument.docs.length; i++) {
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }
      print("Lista likes Recibidos :" + likeReceivedList.toString());

      getKeysDataFromUsersCollection(likeReceivedList);
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
          likeList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likeList;
    });
    print("Lista de Likes:" + likeList.toString());

  }

  @override

  void initState() {
    // TODO: implement initState
    super.initState();

    getLikesListKeys();
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
                likeSentList.clear();
                likeList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likeList.clear();
                likeList = [];

                setState(() {
                  isLikeSentClicked = true;
                });

                getLikesListKeys();
              },
              child: Text(
                "Mis likes",
                style: TextStyle(
                  color:isLikeSentClicked ? Colors.white : Colors.grey,
                  fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
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
                likeSentList.clear();
                likeList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likeList.clear();
                likeList = [];

                setState(() {
                  isLikeSentClicked = false;
                });

                getLikesListKeys();
              },
              child: Text(
                "Me dieron Like",
                style: TextStyle(
                  color:isLikeSentClicked ? Colors.grey : Colors.white,
                  fontWeight: isLikeSentClicked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),


          ],
        ),
        centerTitle: true,
      ),
      body: likeList.isEmpty
          ? const Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white, size:  60,),
      )
          : GridView.count(
        crossAxisCount: 2,
        padding:const EdgeInsets.all(8),
        children: List.generate(likeList.length, (index)
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
                          image: NetworkImage(likeList[index]["imagenPerfil"],),
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
                                likeList[index]["nombre"].toString() + " • " + likeList[index]["Edad"].toString(),
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
                                      likeList[index]["ciudad"].toString() + " , " + likeList[index]["Carrera"].toString(),
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
