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
}
