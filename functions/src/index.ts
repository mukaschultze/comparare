import * as functions from "firebase-functions";
import { productsCollection } from "./db";

// functions.logger.info("Hello logs!", {structuredData: true});

export const getProductFromBarcode = functions.https.onCall(
  async (data, context) => {
    const { barcode } = data;

    if (typeof barcode !== "string") {
      throw new Error(`Invalid barcode type "${typeof barcode}"`);
    }

    const query = productsCollection().where("barcode", "==", barcode);
    const snapshot = await query.get();
    const products = snapshot.docs.map((doc) => doc.data());

    return products;
  }
);
