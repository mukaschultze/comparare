import { Mercado, Preco, Produto } from "@comparare/types/core";
import * as admin from "firebase-admin";
import memoizee from "memoizee";

const productConverter: FirebaseFirestore.FirestoreDataConverter<Produto> = {
  fromFirestore: (snapshot) =>
    ({ ...snapshot.data(), id: snapshot.id } as Produto),
  toFirestore: (data: Partial<Produto>) => ({ ...data, id: undefined }),
};

const precoConverter: FirebaseFirestore.FirestoreDataConverter<Preco> = {
  fromFirestore: (snapshot) =>
    ({ ...snapshot.data(), id: snapshot.id } as Preco),
  toFirestore: (data: Partial<Preco>) => ({ ...data, id: undefined }),
};

const mercadoConverter: FirebaseFirestore.FirestoreDataConverter<Mercado> = {
  fromFirestore: (snapshot) =>
    ({ ...snapshot.data(), id: snapshot.id } as Mercado),
  toFirestore: (data: Partial<Mercado>) => ({ ...data, id: undefined }),
};

export const productsCollection = memoizee(() =>
  admin.firestore().collection(`/produtos`).withConverter(productConverter)
);

export const precosCollection = memoizee(() =>
  admin.firestore().collection(`/precos`).withConverter(precoConverter)
);

export const mercadosCollection = memoizee(() =>
  admin.firestore().collection(`/mercados`).withConverter(mercadoConverter)
);
