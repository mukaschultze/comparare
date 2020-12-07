import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PrecosService {
  final HttpsCallable getProductFromBarcode =
      FirebaseFunctions.instance.httpsCallable(
    'getProductFromBarcode',
  );

  Future<dynamic> scanBarCode(String code) async {
    var result = await getProductFromBarcode.call(<String, dynamic>{
      'barcode': code,
    });
    return result.data;
  }

  Stream<List<dynamic>> getMercados(List<String> ids) {
    return FirebaseFirestore.instance
        .collection('mercados')
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map((data) => data.docs.map((e) => e.data()).toList());
  }
}
