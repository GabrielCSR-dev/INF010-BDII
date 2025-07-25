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

with big_table as
(select
cob.data_competencia,
med.data_medicao,
cob.vencimento,
cli.cod_cliente,
cts.cod_servico,
ctc.cod_comercio,
fun.cpf,
cli.cep,
fun.cep,
total_cobranca as receita,
total_consumo as consumo
from cobranca as cob
	inner join medicao as med
		on(cob.cod_cliente = med.cod_cliente and cob.data_competencia = med.data_competencia)
	inner join cliente as cli
		on(cli.cod_cliente = med.cod_cliente)
	inner join cliente_tipo_servicos as cts
	    on(cts.cod_cliente = cli.cod_cliente)
	inner join cliente_tipo_comercio as ctc
		on(ctc.cod_cliente = cli.cod_cliente)
	inner join funcionario as fun
		on(fun.cpf = med.cpf_responsavel_medicao)
	cross join (
    	select sum(valor_cobranca) as valor_cobranca_total from cobranca
	) as total_cobranca
	cross join (
    	select sum(valor_consumo) as valor_consumo_total from medicao
	) as total_consumo)
insert into fato_relatorio
select 
	data_competencia
