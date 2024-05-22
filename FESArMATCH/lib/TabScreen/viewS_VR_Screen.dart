import 'package:fesarmatch/global.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ViewSVRS extends StatefulWidget {
  const ViewSVRS({super.key});

  @override
  State<ViewSVRS> createState() => _ViewSVRSState();
}

class _ViewSVRSState extends State<ViewSVRS> {

  bool isViewSentClicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List viewsList = [];

  getViewListKeys() async
  {
    if (isViewSentClicked)
    {
      var viewSentDocument = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID.toString()).collection("viewSent")
          .get();

      for (int i = 0; i < viewSentDocument.docs.length; i++) {
        viewSentList.add(viewSentDocument.docs[i].id);
      }
      print("viewSentList=" + viewSentList.toString());
      getKeysDataFromUsersCollection(viewSentList);
    }


    else
    {
      var viewReceivedDocument = await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID.toString()).collection("viewReceived")
          .get();

      for (int i = 0; i < viewReceivedDocument.docs.length; i++) {
        viewReceivedList.add(viewReceivedDocument.docs[i].id);
      }
      print("viewReceivedList =" + viewReceivedList.toString());

      getKeysDataFromUsersCollection(viewReceivedList);
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
          viewsList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      viewsList;
    });
    print("viewsList =" + viewsList.toString());

  }

  @override

  void initState() {
    // TODO: implement initState
    super.initState();

    getViewListKeys();
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
                viewSentList.clear();
                viewsList = [];
                viewReceivedList.clear();
                viewReceivedList = [];
                viewsList.clear();
                viewsList = [];

                setState(() {
                  isViewSentClicked = true;
                });

                getViewListKeys();
              },
              child: Text(
                "Mis Vistos",
                style: TextStyle(
                  color:isViewSentClicked ? Colors.white : Colors.grey,
                  fontWeight: isViewSentClicked ? FontWeight.bold : FontWeight.normal,
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
                viewSentList.clear();
                viewsList = [];
                viewReceivedList.clear();
                viewReceivedList = [];
                viewsList.clear();
                viewsList = [];

                setState(() {
                  isViewSentClicked = false;
                });

                getViewListKeys();
              },
              child: Text(
                "Me Vieron",
                style: TextStyle(
                  color:isViewSentClicked ? Colors.grey : Colors.white,
                  fontWeight: isViewSentClicked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),


          ],
        ),
        centerTitle: true,
      ),
      body: viewsList.isEmpty
          ? const Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white, size:  60,),
      )
          : GridView.count(
        crossAxisCount: 2,
        padding:const EdgeInsets.all(8),
        children: List.generate(viewsList.length, (index)
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
                          image: NetworkImage(viewsList[index]["imagenPerfil"],),
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
                                viewsList[index]["nombre"].toString() + " • " + viewsList[index]["Edad"].toString(),
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
                                      viewsList[index]["ciudad"].toString() + " , " + viewsList[index]["Carrera"].toString(),
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
