ALTER table saldo ENABLE row level security;

CREATE POLICY saldo_select
  on saldo FOR select
                          TO authenticated
                          using (
                          exists (
                          select 1 from carteira
                          WHERE carteira.id_carteira = saldo.id_carteira
                          AND carteira.id_usuario = auth.uid()
                          )
                          );

-- BASICAMENTE O USUARIO VAI VER APENAS O SALDO DA CARTEIRA EM ESPECIFICO