💾 PROJETO MOD2.2: SISTEMA DE GESTÃO DE HORTA COMUNITÁRIA VERDEVIVA
Este repositório contém o projeto de banco de dados para o Sistema de Gestão da Horta Comunitária VerdeViva,
focado na implementação e validação de um modelo relacional para rastreamento completo do ciclo de produção: desde o plantio até a doação.

📌 Estrutura e Arquivos do Projeto
O projeto é dividido em fases lógicas, com os seguintes arquivos em formato SQL e de modelagem:
Ordem,Arquivo,Conteúdo Principal,Finalidade e Aplicação
Fase 1,horta_diagram.mwb,Modelo Lógico (Diagrama EER),"O desenho final do modelo, gerado no MySQL Workbench."
Fase 2,01_schema_creation.Tabelas.sql,Código SQL (CREATE TABLE),"Modelo Físico. Define a estrutura das tabelas, tipos de dados (DECIMAL(10,2)) e todas as restrições (PKs e FKs)."
Fase 2,02_data_inserts.sql,Comandos INSERT INTO,"Popula o banco com os dados de teste essenciais, cumprindo o requisito de mínimo de 3 inserções por tabela."
Fase 3,03_queries_validation.sql,Consultas SQL (SELECT),Validação Funcional. Scripts DML para testar a rastreabilidade e a gestão do banco de dados.
