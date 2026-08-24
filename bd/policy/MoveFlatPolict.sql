ALTER TABLE movimentacao_fiat ENABLE ROW LEVEL SECURITY;


create policy movimentacao_fiat_insert
on movimentacao_fiat for insert
to authenticated
WITH CHECK (
  EXISTS (
      SELECT 1 FROM carteira
      where movimentacao_fiat.id_carteira = carteira.id_carteira
      AND carteira.id_usuario = auth.uid()
  )
)