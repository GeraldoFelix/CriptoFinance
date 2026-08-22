-- WARNING: This schema is for context only and is not meant to be run.
CREATE TABLE public.carteira (
                                 id_carteira integer NOT NULL DEFAULT nextval('carteira_id_carteira_seq'::regclass),
                                 nome_carteira character varying NOT NULL,
                                 saldo_fiat numeric NOT NULL DEFAULT 1000.00,
                                 id_usuario uuid NOT NULL,
                                 CONSTRAINT carteira_pkey PRIMARY KEY (id_carteira),
                                 CONSTRAINT carteira_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario)
);
CREATE TABLE public.criptomoeda (
                                    id_cripto integer NOT NULL DEFAULT nextval('criptomoeda_id_cripto_seq'::regclass),
                                    nome character varying NOT NULL UNIQUE,
                                    anotacoes text,
                                    CONSTRAINT criptomoeda_pkey PRIMARY KEY (id_cripto)
);
CREATE TABLE public.preco_historico (
                                        id_preco integer NOT NULL DEFAULT nextval('preco_historico_id_preco_seq'::regclass),
                                        preco numeric NOT NULL,
                                        momento timestamp without time zone NOT NULL,
                                        id_cripto integer NOT NULL,
                                        CONSTRAINT preco_historico_pkey PRIMARY KEY (id_preco),
                                        CONSTRAINT preco_historico_id_cripto_fkey FOREIGN KEY (id_cripto) REFERENCES public.criptomoeda(id_cripto)
);
CREATE TABLE public.saldo (
                              id_carteira integer NOT NULL,
                              id_cripto integer NOT NULL,
                              quantidade_atual numeric NOT NULL DEFAULT 0,
                              CONSTRAINT saldo_pkey PRIMARY KEY (id_carteira, id_cripto),
                              CONSTRAINT saldo_id_carteira_fkey FOREIGN KEY (id_carteira) REFERENCES public.carteira(id_carteira),
                              CONSTRAINT saldo_id_cripto_fkey FOREIGN KEY (id_cripto) REFERENCES public.criptomoeda(id_cripto)
);
CREATE TABLE public.transacao (
                                  id_transacao integer NOT NULL DEFAULT nextval('transacao_id_transacao_seq'::regclass),
                                  tipo USER-DEFINED NOT NULL,
                                  quantidade numeric NOT NULL,
                                  valor_unitario numeric NOT NULL,
                                  data timestamp without time zone NOT NULL,
                                  id_cripto integer NOT NULL,
                                  id_carteira_origem integer,
                                  id_carteira_destino integer,
                                  CONSTRAINT transacao_pkey PRIMARY KEY (id_transacao),
                                  CONSTRAINT transacao_id_cripto_fkey FOREIGN KEY (id_cripto) REFERENCES public.criptomoeda(id_cripto),
                                  CONSTRAINT transacao_id_carteira_origem_fkey FOREIGN KEY (id_carteira_origem) REFERENCES public.carteira(id_carteira),
                                  CONSTRAINT transacao_id_carteira_destino_fkey FOREIGN KEY (id_carteira_destino) REFERENCES public.carteira(id_carteira)
);
CREATE TABLE public.usuario (
                                id_usuario uuid NOT NULL,
                                nome character varying NOT NULL,
                                email character varying NOT NULL UNIQUE,
                                data_cadastro timestamp with time zone NOT NULL DEFAULT now(),
                                ativo boolean NOT NULL DEFAULT true,
                                CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario)
);
CREATE TABLE public.movimentacao_fiat (
                                          id_movimentacao integer NOT NULL DEFAULT nextval('movimentacao_fiat_id_movimentacao_seq'::regclass),
                                          id_carteira integer NOT NULL,
                                          tipo USER-DEFINED NOT NULL,
                                          valor numeric NOT NULL CHECK (valor > 0::numeric),
  status USER-DEFINED NOT NULL DEFAULT 'pendente'::status_movimentacao_enum,
  metodo character varying NOT NULL,
  data timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT movimentacao_fiat_pkey PRIMARY KEY (id_movimentacao),
  CONSTRAINT movimentacao_fiat_id_carteira_fkey FOREIGN KEY (id_carteira) REFERENCES public.carteira(id_carteira)
);