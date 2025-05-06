CREATE OR REPLACE FUNCTION Nova_Auditoria() RETURNS trigger
AS $Atualiza_Idx$
	DECLARE
		velho_IDX decimal(8,3);
		novo_IDX decimal(8,3);
		diferenca decimal(8,3);
	BEGIN
		velho_IDX = OLD.IDX;
		novo_IDX = (NEW.idh_educacao * NEW.idh_educacao * NEW.idh_longevidade) / NEW.idh_geral;
		diferenca = novo_IDX - velho_IDX;

		UPDATE Indice
		SET IDX = novo_idx
		WHERE CodMunicipio = NEW.CodMunicipio AND Ano = NEW.Ano;
		
		INSERT INTO Auditoria (Data, Valor_Antigo_Idx, Novo_Valor_Idx, Diferenca, Cod_Municipio, Ano) VALUES
		(CURRENT_DATE, velho_IDX, novo_IDX, diferenca, NEW.CodMunicipio, NEW.Ano);
		
		RETURN NEW;
	END;
$Atualiza_Idx$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION IDX_Diferenca_Media_Hoje(refcursor) RETURNS refcursor
AS $$
	BEGIN
		OPEN $1 FOR SELECT AVG(diferenca) FROM Auditoria AS A
			WHERE A.Data = CURRENT_DATE; 
		
		RETURN $1;
	END;
$$ LANGUAGE plpgsql;

-- Teste

SELECT IDX_Diferenca_Media_Hoje('cursor1');
FETCH ALL IN cursor1;