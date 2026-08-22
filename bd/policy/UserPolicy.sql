ALTER TABLE usuario ENABLE ROW LEVEL SECURITY;

create policy usuario_select
  on usuario for select
                            to authenticated
                            using (auth.uid() = id_usuario);

create policy usuario_update
  on usuario for update
                            to authenticated
                            using (auth.uid() = id_usuario)
                 with check (auth.uid() = id_usuario);

create policy usuario_insert
  on usuario for insert
  to authenticated
  with check (auth.uid() = id_usuario);