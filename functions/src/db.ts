import { Product } from "@comparare/types/core";
import * as admin from "firebase-admin";
import memoizee from "memoizee";

const productConverter: FirebaseFirestore.FirestoreDataConverter<Product> = {
  fromFirestore: (snapshot) => snapshot.data() as Product,
  toFirestore: (data: Partial<Product>) => data,
};

export const productsCollection = memoizee(() =>
  admin.firestore().collection(`/produtos`).withConverter(productConverter)
);
