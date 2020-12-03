export interface Produto {
  id: string;
  barcode: string;
  desc: {
    quant: string;
    unit: "peso" | "unidade";
  };
  name: string;
}

export interface Preco {
  id: string;
  mercadoId: string;
  isPromo: boolean;
  preco: number;
  update: string; //é o time do firebase, acho que é timestamp
  produtoId: string;
}

export interface ProdutoPresentation {
  produto: Produto;
  prices: Array<Preco>;
}

export interface Mercado {
  id: string;
  name: string;
  localização?: {
    Latitude: string;
    Longitude: string;
  };
}
