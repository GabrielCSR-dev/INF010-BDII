create table uf (
    cod_uf varchar(2),
    nome varchar(50) not null,
	constraint pk_uf primary key (cod_uf)
);

create table cidade (
    cod_cidade serial,
    nome varchar(50) not null,
    cod_uf varchar(2) not null,
	constraint pk_cidade primary key (cod_cidade),
    constraint fk_cidade_uf foreign key (cod_uf) references uf (cod_uf)
);

create table cep (
    cep varchar(8),
    tipo_logradouro varchar(20),
    logradouro varchar(80) not null,
    bairro varchar(25),
    cod_cidade int not null,
	constraint pk_cep primary key (cep),
    constraint fk_cep_cidade foreign key (cod_cidade) references cidade (cod_cidade)
);

create table cliente (
    cod_cliente serial,
    nome varchar(40) not null,
    cpf_cnpj varchar(14) not null unique,
    cep varchar(8) not null,
    numero int not null,
    complemento varchar(50),
    tipo varchar(15),
	constraint pk_cliente primary key (cod_cliente),
    constraint fk_cliente_cep foreign key (cep) references cep (cep)
);

create table funcionario (
    cpf varchar(11),
    nome varchar(40) not null,
    cep varchar(8) not null,
    numero int not null,
    complemento varchar(50),
	constraint pk_funcionario primary key (cpf),
    constraint fk_funcionario_cep foreign key (cep) references cep (cep)
);

create table setor_comercio (
    cod_comercio serial,
    descricao varchar(25) not null unique,
	constraint pk_comercio primary key (cod_comercio)
);

create table cliente_tipo_comercio (
    cod_cliente integer not null,
    cod_comercio integer not null,
    constraint pk_ctc primary key (cod_cliente, cod_comercio),
    constraint fk_ctc_cliente foreign key (cod_cliente) references cliente (cod_cliente),
    constraint fk_ctc_setor_comercio foreign key (cod_comercio) references setor_comercio (cod_comercio)
);

create table setor_servicos (
    cod_servico serial,
    descricao varchar(25) not null unique,
	constraint pk_servico primary key (cod_servico)
);

create table cliente_tipo_servicos (
    cod_cliente integer not null,
    cod_servico integer not null,
    constraint pk_cts primary key (cod_cliente, cod_servico),
    constraint fk_cts_cliente foreign key (cod_cliente) references cliente (cod_cliente),
    constraint fk_cts_setor_servicos foreign key (cod_servico) references setor_servicos (cod_servico)
);

create table medicao (
    data_competencia date not null,
    cod_cliente int not null,
    data_medicao date not null,
    cpf_responsavel_medicao varchar(14) not null,
    valor_consumo numeric(13, 2) not null,
    constraint pk_medicao primary key (data_competencia, cod_cliente),
    constraint fk_medicao_cliente foreign key (cod_cliente) references cliente (cod_cliente),
    constraint fk_medicao_funcionario foreign key (cpf_responsavel_medicao) references funcionario (cpf)
);

create table cobranca (
    data_competencia date not null,
    cod_cliente int not null,
    vencimento date not null,
    valor_cobranca numeric(13, 2) not null,
    constraint pk_cobranca primary key (data_competencia, cod_cliente), 
    constraint fk_cobranca_cliente foreign key (cod_cliente) references cliente (cod_cliente)
);