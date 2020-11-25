import { Product } from "@comparare/types/core";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

// functions.logger.info("Hello logs!", {structuredData: true});

const productConverter: FirebaseFirestore.FirestoreDataConverter<Product> = {
  fromFirestore: (snapshot) => snapshot.data() as Product,
  toFirestore: (data: Partial<Product>) => data,
};

const productsCollection = admin
  .firestore()
  .collection(`/produtos`)
  .withConverter(productConverter);

export const getProductFromBarcode = functions.https.onCall(
  async (data, context) => {
    const { barcode } = data;

    if (typeof barcode !== "string") {
      throw new Error(`Invalid barcode type "${typeof barcode}"`);
    }

    const query = productsCollection.where("barcode", "==", barcode);
    const snapshot = await query.get();
    const products = snapshot.docs.map((doc) => doc.data());

    return products;
  }
);
