-- Garante que as operações sejam feitas no banco correto
USE mydb;

-- -------------------------------------------------------------------------------------------------
-- CONSULTA CRÍTICA: RASTREABILIDADE DO ALIMENTO (Plantio -> Colheita -> Doação)
-- Requisito: Visualizar quem plantou, o que, quando colheu, quanto foi doado e para quem.
-- -------------------------------------------------------------------------------------------------
SELECT
    V.nome_voluntario AS Voluntario_Plantio,
    P.nome_planta AS Planta_Cultivada,
    CULT.data_plantio AS Data_Plantio,
    COLH.data_colheita AS Data_Colheita,
    COLH.quant_colheita AS Quantidade_Colhida_Total,
    ID.quanti_doada AS Quantidade_Doada_Deste_Item,
    I.nome_insti AS Instituicao_Beneficiada,
    D.data_doacao AS Data_Doacao
FROM
    Cultivo CULT
INNER JOIN 
    Voluntario V ON CULT.idVoluntario = V.idVoluntario 
INNER JOIN
    Planta P ON CULT.idPlanta = P.idPlanta
INNER JOIN
    Colheita COLH ON COLH.idCultivo = CULT.idCultivo 
INNER JOIN
    Item_Doacao ID ON ID.idColheita = COLH.idColheita 
INNER JOIN
    Doacao D ON ID.idDoacao = D.idDoacao
INNER JOIN
    Instituicao I ON D.idInstituicao = I.idInstituicao
WHERE 
    V.nome_voluntario = 'Mariana Silva'; -- Adiciona um filtro para o dado que inserimos

-- -------------------------------------------------------------------------------------------------
-- TESTE DE INTEGRIDADE: Verificar a quantidade total doada por Colheita (prova do N:N)
-- -------------------------------------------------------------------------------------------------
SELECT 
    COLH.idColheita, 
    COLH.quant_colheita AS Colhido,
    SUM(ID.quanti_doada) AS Total_Doado
FROM 
    Colheita COLH
INNER JOIN 
    Item_Doacao ID ON COLH.idColheita = ID.idColheita
GROUP BY 
    COLH.idColheita;
    
-- Garante que as operações sejam feitas no banco correto
USE mydb;

-- -------------------------------------------------------------------------------------------------
-- ETAPA 4: CONSULTAS SQL (DML) - 10 REQUISITOS
-- (Assumindo que os dados de teste já foram inseridos pelo 02_data_inserts.sql)
-- -------------------------------------------------------------------------------------------------

-- 1. Liste todos os voluntários cadastrados e suas respectivas funções.
SELECT
    idVoluntario,
    nome_voluntario
FROM
    Voluntario;

-- 2. Mostre as plantas cultivadas em cada canteiro, com o nome do canteiro e a data do plantio.
SELECT
    C.nome_canteiro,
    P.nome_planta,
    T.data_plantio
FROM
    Cultivo T
INNER JOIN
    Canteiro C ON T.idCanteiro = C.idCanteiro
INNER JOIN
    Planta P ON T.idPlanta = P.idPlanta;

-- 3. Exiba os nomes dos voluntários e as plantas que eles cultivaram.
SELECT DISTINCT
    V.nome_voluntario,
    P.nome_planta
FROM
    Cultivo CULT
INNER JOIN
    Voluntario V ON CULT.idVoluntario = V.idVoluntario
INNER JOIN
    Planta P ON CULT.idPlanta = P.idPlanta
ORDER BY 
    V.nome_voluntario;

-- 4. Liste todas as colheitas realizadas, mostrando o canteiro e a quantidade colhida (em kg).
SELECT
    CANT.nome_canteiro,
    COLH.data_colheita,
    COLH.quant_colheita
FROM
    Colheita COLH
INNER JOIN
    Cultivo CULT ON COLH.idCultivo = CULT.idCultivo 
INNER JOIN
    Canteiro CANT ON CULT.idCanteiro = CANT.idCanteiro;

-- 5. Mostre as instituições que receberam doações e as quantidades doadas.
SELECT
    I.nome_insti,
    D.data_doacao,
    SUM(ID.quanti_doada) AS Quantidade_Total_Doada_Kg
FROM
    Doacao D
INNER JOIN
    Instituicao I ON D.idInstituicao = I.idInstituicao
INNER JOIN
    Item_Doacao ID ON D.idDoacao = ID.idDoacao
GROUP BY
    D.idDoacao, I.nome_insti, D.data_doacao;

-- 6. Liste o total de quilos doados por instituição (use GROUP BY).
SELECT
    I.nome_insti AS Instituicao,
    SUM(ID.quanti_doada) AS Total_Quilos_Doados
FROM
    Instituicao I
INNER JOIN
    Doacao D ON I.idInstituicao = D.idInstituicao
INNER JOIN
    Item_Doacao ID ON D.idDoacao = ID.idDoacao
GROUP BY
    I.nome_insti
ORDER BY
    Total_Quilos_Doados DESC;

-- 7. Mostre os canteiros que ainda não tiveram colheitas (use LEFT JOIN).
-- ATENÇÃO: Essa consulta depende que haja um Canteiro sem Cultivos/Colheitas nos dados de teste.
SELECT
    C.nome_canteiro
FROM
    Canteiro C
LEFT JOIN
    Cultivo T ON C.idCanteiro = T.idCanteiro 
LEFT JOIN
    Colheita COLH ON T.idCultivo = COLH.idCultivo 
WHERE
    COLH.idColheita IS NULL; 

-- 8. Exiba o voluntário que realizou o maior número de cultivos (use COUNT e ORDER BY).
SELECT
    V.nome_voluntario,
    COUNT(CULT.idCultivo) AS Total_Cultivos
FROM
    Voluntario V
INNER JOIN
    Cultivo CULT ON V.idVoluntario = CULT.idVoluntario
GROUP BY
    V.nome_voluntario
ORDER BY
    Total_Cultivos DESC
LIMIT 1; 

-- 9. Mostre as plantas que ainda não foram colhidas (utilizando subconsulta ou LEFT JOIN).
SELECT
    P.nome_planta
FROM
    Planta P
INNER JOIN
    Cultivo CULT ON P.idPlanta = CULT.idPlanta 
LEFT JOIN
    Colheita COLH ON CULT.idCultivo = COLH.idCultivo 
WHERE
    COLH.idColheita IS NULL; 

-- 10. Liste todas as doações realizadas em setembro de 2025, com o nome da instituição e a data da doação.
-- ATENÇÃO: Retornará vazio se não houver dados de setembro.
SELECT
    D.idDoacao,
    I.nome_insti,
    D.data_doacao
FROM
    Doacao D
INNER JOIN
    Instituicao I ON D.idInstituicao = I.idInstituicao
WHERE
    YEAR(D.data_doacao) = 2025 AND MONTH(D.data_doacao) = 9;    