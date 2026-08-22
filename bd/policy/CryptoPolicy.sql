ALTER TABLE criptomoeda ENABLE ROW LEVEL SECURITY;

create policy criptomoeda_select
  on criptomoeda for select
                                to authenticated
                                using (true); -- todos podem acessar a table cripto