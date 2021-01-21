import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PrecosService {
  final HttpsCallable getProductFromBarcode =
      FirebaseFunctions.instance.httpsCallable(
    'getProductFromBarcode',
  );

  // Future<dynamic> scanBarCode(String code) async {
  //   var result = await getProductFromBarcode.call(<String, dynamic>{
  //     'barcode': code,
  //   });
  //   return result.data;
  // }

  Stream<List<dynamic>> getMercados(List<String> ids) {
    return FirebaseFirestore.instance
        .collection('mercados')
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map((data) => data.docs.map((e) => e.data()).toList());
  }

  Future<dynamic> getAllMercados() {
    return FirebaseFirestore.instance
        .collection('mercados')
        .get()
        .then((value) => value.docs)
        .catchError((onError) => print(onError));
    // .snapshots()
    // .map((data) => data.docs.map((e) => e.data())));
  }

  Future<dynamic> scanBarCode(String code) async {
    try {
      var prodDoc = FirebaseFirestore.instance.collection('produtos').doc(code);
      var pricesCol = prodDoc.collection("prices");

      var prodSnapshot = await prodDoc.get();

      if (!prodSnapshot.exists) return null;

      var prodValue = prodSnapshot.data();
      var pricesValue = (await pricesCol.get()).docs.map((e) => e.data());

      prodValue["prices"] = pricesValue;

      return prodValue;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
