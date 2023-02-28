import 'package:cloud_firestore/cloud_firestore.dart';

List<Map<String, dynamic>> buses_start = [
];
List<Map<String, dynamic>> buses_end = [
];

Future getbuses(String Start, String End) async{
  // Initialize Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

// Reference to the collection in Firestore
  CollectionReference collectionReference = firestore.collection('Timings');

// Query to fetch documents with a particular field
  // finding buses with start loaction
  QuerySnapshot querySnapshot = await collectionReference
      .where("TimeValue",isGreaterThan: 500)
      .where("Place", isEqualTo: Start).orderBy("TimeValue",descending: false).get();

// Loop through the querySnapshot to access the documents
  int i=0;
  for (var document in querySnapshot.docs) {
    //print(document.data() as Map<String, dynamic>);
    buses_start.add(document.data() as Map<String, dynamic>);
    print(buses_start[i]['BusId']);
    QuerySnapshot end=await FirebaseFirestore.instance
        .collection('Timings')
        .where("Place",isEqualTo: End )
        .where("BusId", isEqualTo: buses_start[i]['BusId'])
        .where("Slot", isEqualTo: buses_start[i]['Slot'])
        .where("TimeValue", isGreaterThan: buses_start[i]['TimeValue'])
        .get();
    if(end.docs.length==0){
      buses_start.removeAt(i);
    }
    print(end.docs);
    for(var d in end.docs){
      buses_end.add(d.data() as Map<String, dynamic>);
    }
   i=i+1;
  }
  print(buses_start);
  print(buses_start.length);
  print(buses_end);
  print(buses_end.length);
}