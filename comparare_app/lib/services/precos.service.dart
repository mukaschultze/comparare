import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:comparare_app/models/productData.dart';

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

  Stream<List<dynamic>> getAllMercados() {
    return FirebaseFirestore.instance
        .collection('mercados')
        .snapshots()
        .map((data) => data.docs.map((e) => e.data()).toList());
  }

  Future<dynamic> scanBarCode(String code) {
    //   FirebaseFirestore.instance
    //       .collection('produtos')
    //       .where("barcode", isEqualTo: code)
    //       .snapshots()
    //       .map((data) => data.docs.map((e) => e.data()));
    return FirebaseFirestore.instance
        .collection('produtos')
        .where("barcode", isEqualTo: code)
        .get()
        .then((value) => value.docs.first.data())
        .catchError((onError) => print(onError));
        // .snapshots()
        // .map((data) => data.docs.map((e) => e.data())));
  }
}
