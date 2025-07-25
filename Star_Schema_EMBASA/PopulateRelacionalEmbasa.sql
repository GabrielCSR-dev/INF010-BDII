-- Populating UF
INSERT INTO uf (cod_uf, nome) VALUES
('SP', 'São Paulo'),
('RJ', 'Rio de Janeiro'),
('MG', 'Minas Gerais'),
('BA', 'Bahia');

-- Populating CIDADE
-- Note: cod_cidade is SERIAL, so we omit it and let PostgreSQL generate it.
INSERT INTO cidade (nome, cod_uf) VALUES
('São Paulo', 'SP'),
('Campinas', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG'),
('Salvador', 'BA');

-- Populating CEP
-- Assuming cod_cidade values based on the order of insertion above (1 for SP, 2 for Campinas, etc.)
INSERT INTO cep (cep, tipo_logradouro, logradouro, bairro, cod_cidade) VALUES
('01000000', 'Rua', 'Rua da Consolação', 'Centro', (SELECT cod_cidade FROM cidade WHERE nome = 'São Paulo' AND cod_uf = 'SP')),
('13000000', 'Avenida', 'Avenida Brasil', 'Centro', (SELECT cod_cidade FROM cidade WHERE nome = 'Campinas' AND cod_uf = 'SP')),
('20000000', 'Praça', 'Praça XV de Novembro', 'Centro', (SELECT cod_cidade FROM cidade WHERE nome = 'Rio de Janeiro' AND cod_uf = 'RJ')),
('30000000', 'Rua', 'Rua da Bahia', 'Centro', (SELECT cod_cidade FROM cidade WHERE nome = 'Belo Horizonte' AND cod_uf = 'MG')),
('40000000', 'Avenida', 'Avenida Sete de Setembro', 'Centro', (SELECT cod_cidade FROM cidade WHERE nome = 'Salvador' AND cod_uf = 'BA')),
('01001000', 'Rua', 'Rua Augusta', 'Consolação', (SELECT cod_cidade FROM cidade WHERE nome = 'São Paulo' AND cod_uf = 'SP')),
('13001000', 'Rua', 'Rua Barão de Jaguara', 'Centro', (SELECT cod_cidade FROM cidade WHERE nome = 'Campinas' AND cod_uf = 'SP'));


-- Populating FUNCIONARIO
INSERT INTO funcionario (cpf, nome, cep, numero, complemento) VALUES
('11122233344', 'João Silva', '01000000', '123', 'Apto 101'),
('55566677788', 'Maria Souza', '20000000', '45', 'Sala 203'),
('99900011122', 'Pedro Costa', '30000000', '789', NULL);

-- Populating CLIENTE
INSERT INTO cliente (nome, cpf_cnpj, cep, numero, complemento, tipo) VALUES
('Empresa Alfa Ltda', '12345678000190', '01000000', 500, 'Andar 5', 'comercial'),
('Residência Beta', '11111111111', '01001000', 10, NULL, 'residencial'),
('Indústria Gama S.A.', '98765432000110', '13000000', 1200, 'Galpão A', 'industrial'),
('Comércio Delta', '22222222222', '13001000', 30, 'Loja 1', 'comercial'),
('Residência Epsilon', '33333333333', '40000000', 250, 'Casa 2', 'residencial');


-- Populating SETOR_COMERCIO
INSERT INTO setor_comercio (descricao) VALUES
('Varejo'),
('Atacado'),
('Serviços Financeiros'),
('Tecnologia');

-- Populating CLIENTE_TIPO_COMERCIO
-- Assuming cod_cliente and cod_comercio values based on insertion order (1, 2, 3, etc.)
INSERT INTO cliente_tipo_comercio (cod_cliente, cod_comercio) VALUES
((SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), (SELECT cod_comercio FROM setor_comercio WHERE descricao = 'Varejo')),
((SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), (SELECT cod_comercio FROM setor_comercio WHERE descricao = 'Tecnologia')),
((SELECT cod_cliente FROM cliente WHERE nome = 'Comércio Delta'), (SELECT cod_comercio FROM setor_comercio WHERE descricao = 'Varejo'));

-- Populating SETOR_SERVICOS
INSERT INTO setor_servicos (descricao) VALUES
('Consultoria'),
('Educação'),
('Saúde'),
('Transporte');

-- Populating CLIENTE_TIPO_SERVICOS
INSERT INTO cliente_tipo_servicos (cod_cliente, cod_servico) VALUES
((SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), (SELECT cod_servico FROM setor_servicos WHERE descricao = 'Consultoria')),
((SELECT cod_cliente FROM cliente WHERE nome = 'Indústria Gama S.A.'), (SELECT cod_servico FROM setor_servicos WHERE descricao = 'Transporte'));

-- Populating MEDICAO
INSERT INTO medicao (data_competencia, cod_cliente, data_medicao, cpf_responsavel_medicao, valor_consumo) VALUES
('2024-01-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), '2024-01-05', '11122233344', 1500.25),
('2024-01-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Residência Beta'), '2024-01-06', '11122233344', 250.75),
('2024-02-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), '2024-02-05', '55566677788', 1600.00),
('2024-02-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Residência Beta'), '2024-02-06', '55566677788', 280.50),
('2024-01-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Indústria Gama S.A.'), '2024-01-07', '99900011122', 5000.00);


-- Populating COBRANCA
INSERT INTO cobranca (data_competencia, cod_cliente, vencimento, valor_cobranca) VALUES
('2024-01-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), '2024-01-15', 1500.25),
('2024-01-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Residência Beta'), '2024-01-16', 250.75),
('2024-02-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Empresa Alfa Ltda'), '2024-02-15', 1600.00),
('2024-02-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Residência Beta'), '2024-02-16', 280.50),
('2024-01-01', (SELECT cod_cliente FROM cliente WHERE nome = 'Indústria Gama S.A.'), '2024-01-17', 5000.00);