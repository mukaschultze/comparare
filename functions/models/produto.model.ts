import { Mercado } from "./mercado.model";

export interface Produto{
    barcode: string;
    desc: {
        quant: string;
        unit: "peso" | "unidade";
    };
    name: string
}

export interface Preco{
    mercado: Mercado;
    isPromo: boolean;
    preco: number;
    update: string //é o time do firebase, acho que é timestamp
}


export interface ProdutoPresntation{
    produto: Produto;
    prices: Array<Preco>
}