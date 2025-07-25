insert into fato_relatorio
	(data_competencia,
	data_medicao,
	data_vencimento,
	cod_cliente,
	cod_servico,
	cod_comercio,
	cpf_funcionario,
	cep_cliente,
	cep_funcionario,
	receita,
	consumo)
select
cob.data_competencia,
med.data_medicao,
cob.vencimento,
cli.cod_cliente,
cts.cod_servico,
ctc.cod_comercio,
fun.cpf,
cli.cep,
fun.cep,
total_cobranca.valor_cobranca_total as receita,
total_consumo.valor_consumo_total as consumo
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
	) as total_consumo;

insert into dim_cliente
select
	cli.cod_cliente,
	ser.cod_servico,
	com.cod_comercio,
	cli.nome,
	cli.cpf_cnpj,
	cli.numero,
	cli.complemento,
	cli.tipo,
	ser.descricao,
	com.descricao
from cliente as cli
	inner join cliente_tipo_servicos as cts
		on(cli.cod_cliente = cts.cod_cliente)
	inner join setor_servicos as ser
		on(cts.cod_servico = ser.cod_servico)
	inner join cliente_tipo_comercio as ctc
		on(ctc.cod_cliente = cli.cod_cliente)
	inner join setor_comercio as com
		on(ctc.cod_comercio = com.cod_comercio);

insert into dim_funcionario
select cpf, nome, numero, complemento from funcionario;

