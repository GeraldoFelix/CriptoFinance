ALTER TABLE transacao ENABLE ROW LEVEL SECURITY;

GRANT select, insert on transacao to authenticated;

CREATE POLICY transacao_select
    ON transacao FOR SELECT
                                TO authenticated
                                USING (
                                EXISTS (
                                SELECT 1 FROM carteira
                                WHERE (carteira.id_carteira = transacao.id_carteira_origem
                                OR carteira.id_carteira = transacao.id_carteira_destino)
                                AND carteira.id_usuario = auth.uid()
                                )
                                );

CREATE POLICY transacao_insert
    ON transacao FOR INSERT
    TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM carteira
            WHERE carteira.id_carteira = transacao.id_carteira_origem
            AND carteira.id_usuario = auth.uid()
        )
    );