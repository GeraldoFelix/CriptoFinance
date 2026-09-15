ALTER TABLE criptomoeda ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON criptomoeda TO anon, authenticated;

create policy criptomoeda_select
  on criptomoeda for select
  to anon, authenticated
  using (true); -- todos podem acessar a table cripto, tanto anons quanto logados
