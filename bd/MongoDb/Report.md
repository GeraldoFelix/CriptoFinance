# CriptoFinance — Atividade: Modelagem MongoDB (Orientada a Documentos)

**Autor:** Geraldo Felix da Silva Junior
**Data:** Agosto de 2026

---

## 1. Objetivo da atividade

Criar um banco de dados no MongoDB e modelar o conceitual da modelagem relacional feita anteriormente, adaptando-a para uma modelagem orientada a documentos, seguindo boas práticas.

---

## 2. O que foi feito

### 2.1 Criação do cluster e conexão

1. Criado um cluster no **MongoDB Atlas**
2. Realizada a conexão do cluster com o **MongoDB Compass**, utilizando a connection string fornecida pelo Atlas.
3. Criado o banco de dados `criptofinance` diretamente pelo Compass.



### 2.2 Decisões de modelagem (embedding vs referencing)

O ponto central do trabalho foi decidir, para cada entidade do modelo relacional original (feito em BD1), se ela deveria ser **embutida** (nested/embedded) dentro de outro documento ou mantida como uma **coleção própria**, referenciada por identificador. A decisão seguiu o critério de:

- **Embutir** quando o dado é uma lista pequena, estável, e sempre consultada em conjunto com o documento "pai".
- **Referenciar** (coleção separada) quando o dado cresce sem limite ao longo do tempo, ou é compartilhado entre múltiplos documentos.

| Dado | Estratégia adotada | Justificativa |
|---|---|---|
| Carteiras do usuário | Embutido em `usuarios` | Poucas carteiras por usuário; sempre lidas junto do perfil |
| Saldo de cripto por carteira | Embutido dentro da carteira | Lista pequena; sempre consultada junto da carteira |
| Transações | Coleção própria (`transacoes`) | Cresce sem limite ao longo do tempo |
| Movimentações fiat (depósito/saque) | Coleção própria (`movimentacoes_fiat`) | Cresce sem limite ao longo do tempo |
| Criptomoedas | Coleção própria (`criptomoedas`) | Dado de catálogo, compartilhado por todo o sistema, não pertence a um único usuário |
| Preço histórico | Coleção própria (`precos_historico`) | Série temporal; cresce continuamente a cada nova cotação |

### 2.3 Criação das coleções

A partir da conexão estabelecida, foram criadas as seguintes coleções, cada uma populada com documentos de exemplo representando dados reais do domínio do sistema:

- `usuarios`
- `criptomoedas`
- `precos_historico`
- `transacoes`
- `movimentacoes_fiat`

## 3. Considerações finais

A modelagem evitou reproduzir a estrutura relacional "tabela por tabela" (o que seria apenas simular um banco relacional dentro do MongoDB). Em vez disso, buscou-se aproveitar os recursos nativos de documentos, como arrays aninhados, mantendo em coleções separadas apenas os dados que crescem de forma ilimitada ou são compartilhados entre diferentes usuários.