-- SELECT * FROM Regiao;

-- CREATE VIEW IDH_GERAL_BAHIA AS
-- 	(SELECT I.idh_geral FROM indice AS I
-- 		INNER JOIN Municipio AS M
-- 			ON(I.codmunicipio = M.codmunicipio)
-- 	WHERE M.codestado = 5);
ALTER TABLE indice
ADD IDX decimal(8,3);
	
CREATE OR REPLACE PROCEDURE IDX()
LANGUAGE SQL
AS $$
	UPDATE indice AS I
	SET IDX = (I.idh_educacao * I.idh_educacao * I.idh_longevidade) / I.idh_geral;
$$;
;

CALL IDX();
SELECT * FROM Indice;

-- CREATE OR REPLACE PROCEDURE Alter_Auditoria() RETURNS trigger AS $Update_Idx$
-- LANGUAGE SQL
-- AS $$
-- 	INSERT
-- 	CALL IDX();
-- 	INSERT INTO Auditoria (Id, Data, Valor_Antigo_Idx, Novo_Valor_Idx, Diferenca, Cod_Municipio, Ano) VALUES
-- 	()
-- $$;
-- ;
