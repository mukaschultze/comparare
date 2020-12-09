import { ProdutoPresentation } from "@comparare/types/core";
import * as firebase from "firebase-admin";
import * as functions from "firebase-functions";
import { mercadosCollection, precosCollection, productsCollection } from "./db";

// functions.logger.info("Hello logs!", {structuredData: true});

firebase.initializeApp();

export const getProductFromBarcode = functions.https.onCall(
  async (data, context) => {
    const { barcode } = data;

    if (typeof barcode !== "string") {
      throw new Error(`Invalid barcode type "${typeof barcode}"`);
    }

    const productsQuery = productsCollection().where("barcode", "==", barcode);
    const productsSnapshot = await productsQuery.get();
    const products = productsSnapshot.docs.map((doc) => doc.data());
    const productsIds = products.map((p) => p.id);

    const precosQuery =
      productsIds.length > 0
        ? precosCollection().where("produtoId", "in", productsIds)
        : undefined;
    const precosSnapshot = await precosQuery?.get();
    const precos = precosSnapshot?.docs.map((doc) => doc.data()) || [];

    const precosIds = precos
      .map((p) => p.mercadoId)
      .map((id) => mercadosCollection().doc(id));
    const mercadosQuery =
      precosIds.length > 0
        ? mercadosCollection().where(
            firebase.firestore.FieldPath.documentId(),
            "in",
            precosIds
          )
        : undefined;
    const mercadosSnapshot = await mercadosQuery?.get();
    const mercados = mercadosSnapshot?.docs.map((doc) => doc.data()) || [];

    return {
      precos: products.map(
        (produto) =>
          ({
            produto,
            prices: precos.filter((p) => p.produtoId === produto.id),
          } as ProdutoPresentation)
      ),
      mercados,
    };
  }
);
