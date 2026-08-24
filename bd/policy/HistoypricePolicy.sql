ALTER TABLE preco_historico ENABLE ROW LEVEL SECURITY;

create policy preco_historico_select
  on preco_historico for select
                                    to authenticated
                                    using (true); -- todos podem acessar a table de preco historico