
/* Star_Schema_EMBASA: */

create table dim_cliente(
	cod_cliente int,
	cod_servico int,
	cod_comercio int,
	nome varchar(40),
	cpf_cnpj varchar(14),
	numero int,
	complemento varchar(50),
	tipo int,
	desc_servico varchar(50),
	desc_comercio varchar(50)
);

create table dim_local(
	cep varchar(08),
	uf varchar(02),
	cidade varchar(50),
	tipo_logradouro int,
	logradouro varchar(80),
	bairro varchar(50)
);

create table dim_funcionario(
	cpf_funcionario varchar(11),
	nome varchar(40),
	numero int,
	complemento varchar(50)
);

create table dim_med_cobr(
	data_competencia date,
	cod_cliente int,
	valor_consumo decimal(13,2),
	valor_cobranca decimal(13,2)
);

create table dim_data(
	cod_data date,
	mes int,
	ano int,
	dia int,
	trimestre int,
	semestre int,
	dia_da_semana varchar(03)
);

create table fato_relatorio(
	cod_receita serial,
	data_competencia date,
	data_medicao date,
	data_vencimento date,
	cod_cliente int,
	cod_servico int,
	cod_comercio int,
	cpf_funcionario varchar(11),
	cep_cliente varchar(08),
	cep_funcionario varchar(08),
	receita decimal(13,2),
	consumo decimal(13,2)
);
