USE mydb;

-- -----------------------------------------------------
-- 1. REGISTROS NAS TABELAS PAIS (3 registros cada)
-- -----------------------------------------------------

-- Voluntario (V1, V2, V3)
INSERT INTO Voluntario (nome_voluntario) VALUES 
('Mariana Silva'),
('João Pereira'),
('Ana Costa'); 

-- Instituicao (I1, I2, I3)
INSERT INTO Instituicao (nome_insti, endereco_insti) VALUES 
('Lar da Esperança', 'Rua das Flores, 100, Centro'),
('Abrigo do Sol', 'Avenida das Árvores, 201, Jardim'),
('Centro Comunitário', 'Praça da Matriz, 50, Vila Nova');

-- Canteiro (C1, C2, C3)
INSERT INTO Canteiro (nome_canteiro, tipo_solo) VALUES 
('Canteiro Principal', 'Argiloso'),
('Canteiro Leste', 'Arenoso'),
('Canteiro Oeste', 'Misto');

-- Planta (P1, P2, P3)
INSERT INTO Planta (nome_planta, dias_colheita) VALUES 
('Alface Crespa', 45),
('Tomate Cereja', 60),
('Cenoura', 75);

-- -----------------------------------------------------
-- 2. REGISTROS INTERLIGADOS (Filhas e N:N - 3 registros cada)
-- -----------------------------------------------------

-- Cultivo (V1, C1, P1), (V2, C2, P2), (V3, C3, P3)
INSERT INTO Cultivo (idVoluntario, idCanteiro, idPlanta, data_plantio, quanti_plantada) 
VALUES 
(1, 1, 1, '2025-05-01', 5.00),  -- Cultivo 1: Mariana plantou Alface no Canteiro Principal
(2, 2, 2, '2025-04-01', 8.50),  -- Cultivo 2: João plantou Tomate no Canteiro Leste
(3, 3, 3, '2025-03-01', 12.00); -- Cultivo 3: Ana plantou Cenoura no Canteiro Oeste


-- Colheita (Colh1, Colh2, Colh3)
INSERT INTO Colheita (idCultivo, idVoluntario, data_colheita, quant_colheita) 
VALUES 
(1, 1, '2025-06-15', 3.50),  -- Colheita 1 (do Cultivo 1)
(2, 2, '2025-06-01', 7.00),  -- Colheita 2 (do Cultivo 2)
(3, 3, '2025-05-15', 10.50); -- Colheita 3 (do Cultivo 3)


-- Doacao (D1, D2, D3)
INSERT INTO Doacao (data_doacao, idInstituicao) 
VALUES 
('2025-06-16', 1), -- Doação 1 para Lar da Esperança
('2025-06-02', 2), -- Doação 2 para Abrigo do Sol
('2025-05-16', 3); -- Doação 3 para Centro Comunitário


-- Item_Doacao (ID1, ID2, ID3)
INSERT INTO Item_Doacao (idDoacao, idColheita, quanti_doada) 
VALUES 
(1, 1, 3.00),  -- 3.00kg da Colheita 1 foram para a Doação 1
(2, 2, 6.50),  -- 6.50kg da Colheita 2 foram para a Doação 2
(3, 3, 9.50);  -- 9.50kg da Colheita 3 foram para a Doação 3