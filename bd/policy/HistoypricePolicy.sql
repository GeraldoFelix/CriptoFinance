ALTER TABLE preco_historico ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON preco_historico TO anon, authenticated;

create policy preco_historico_select
  on preco_historico for select
                                    to anon, authenticated
                                    using (true); -- todos podem acessar a table de preco historico
