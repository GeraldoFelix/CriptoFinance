ALTER TABLE carteira ENABLE ROW LEVEL SECURITY;

GRANT SELECT, update, insert ON carteira TO authenticated;

create policy carteira_insert
  on carteira for insert
  to authenticated 
  with check(auth.uid() = id_usuario);

create policy carteira_update
  on carteira for update
  to authenticated
  using (auth.uid() = id_usuario)
  with check(auth.uid() = id_usuario);

create policy carteira_select
  on carteira for select
  to authenticated 
  using (auth.uid() = id_usuario);

-- terminado
