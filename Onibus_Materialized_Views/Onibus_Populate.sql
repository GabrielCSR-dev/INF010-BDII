INSERT INTO Passageiro (CPF, Nome) VALUES
('11122233344', 'Ana Santos'),
('22233344455', 'Bruno Oliveira'),
('33344455566', 'Carla Mendes'),
('44455566677', 'Daniel Costa'),
('55566677788', 'Elena Pereira');

INSERT INTO Linha (Numero, Nome) VALUES
(101, 'Centro - Zona Norte'),
(202, 'Jardim Botânico - Praia'),
(303, 'Aeroporto - Centro'),
(404, 'Circular Universitário'),
(505, 'Expresso Shopping');

INSERT INTO Turno (Cod_Turno, Caixa, Numero_Linha) VALUES
(1, 1850.75, 101),
(2, 2200.50, 202),
(3, 1500.00, 303),
(4, 1950.25, 404),
(5, 2100.90, 505),
(6, 1750.30, 101),
(7, 2300.60, 202);

INSERT INTO Viagem (Cod_Viagem, CPF_Passageiro, Cod_Turno) VALUES
(1, '11122233344', 1),
(2, '22233344455', 1),
(3, '33344455566', 2),
(4, '44455566677', 3),
(5, '55566677788', 4),
(6, '11122233344', 5),
(7, '22233344455', 6),
(8, '33344455566', 7),
(9, '44455566677', 1),
(10, '55566677788', 2);