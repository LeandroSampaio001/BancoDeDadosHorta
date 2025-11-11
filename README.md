# 🌳 PROJETO MOD2.2: SISTEMA DE GESTÃO DE HORTA COMUNITÁRIA VERDEVIVA

Este repositório implementa o banco de dados relacional para a Horta Comunitária VerdeViva, focado na **rastreabilidade completa** do ciclo de produção: **Plantio** → **Colheita** → **Doação**.

---

## 1. Visão Geral e Arquivos do Modelo

O projeto cobre todas as fases do design de banco de dados, desde o conceito até a implementação física:

### Arquivos Chave:
* **`diagrama.logico.png`**: Representa o **Modelo Conceitual** (Entidades e Relacionamentos puros).
* **`diagrama.fisico.png`**: Uma imagem do **Modelo Lógico** (Diagrama EER do Workbench), mostrando atributos e cardinalidade.
* **`01_criacao.Tabelas.sql`**: Contém o **Modelo Físico** (`CREATE TABLE` e restrições).
* **`02_inserts.sql`**: Script com comandos `INSERT INTO`, preenchendo o banco com o mínimo de 3 registros por tabela.
* **`03_validacoes.sql`**: Scripts SQL de DML para o teste funcional e rastreamento.

---

## 2. Estrutura e Funcionamento do Banco

O sistema é baseado em 8 entidades, com destaque para a resolução de um relacionamento Muitos para Muitos (N:N) que era um requisito chave:

| Entidade | Função Primária | Relacionamentos Chave |
| :--- | :--- | :--- |
| **Cultivo** | Evento de plantio. Liga **Voluntário**, **Canteiro** e **Planta**. | 1:N com Voluntário, Canteiro, Planta. |
| **Colheita** | Evento de retirada do produto. | 1:N com Cultivo. |
| **Doacao** e **Item\_Doacao** | Rastreia a entrega. A tabela **`Item_Doacao`** resolve o N:N, permitindo que uma doação seja suprida por várias colheitas. | N:N resolvido entre Colheita e Doacao. |

---

## 3. Propósito das Consultas de Validação (`03_validacoes.sql`)

As consultas provam a capacidade de gestão e a integridade do sistema, respondendo diretamente aos requisitos de rastreabilidade:

| Consulta | Propósito/Justificativa |
| :--- | :--- |
| **Consulta 1** (Rastreabilidade Completa) | **Validação principal.** Demonstra a rastreabilidade: "Quem plantou o quê, quando colheu e para quem foi doado." |
| **Consultas 2, 3, 4** | Listagem de dados cadastrais e operacionais (Cultivos, Colheitas). |
| **Consulta 6** (GROUP BY) | Demonstra o uso de agregação para **análise gerencial** (Total doado por instituição). |
| **Consulta 7** (LEFT JOIN) | Demonstra o uso de `LEFT JOIN` para **controle de inventário**, identificando canteiros que foram cultivados, mas que ainda não tiveram colheita registrada. |
| **Consulta 8** (COUNT) | Demonstra a capacidade de **gestão de recursos humanos** (identificando o voluntário mais ativo). |
| **Consulta 9** (LEFT JOIN) | Identifica plantas plantadas que estão "em campo" e ainda não foram colhidas, ajudando no **planejamento de colheita**. |
