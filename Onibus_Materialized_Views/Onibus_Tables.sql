CREATE TABLE Passageiro(
	CPF VARCHAR(11) NOT NULL,
	Nome VARCHAR(30) NOT NULL,
	CONSTRAINT pk_passageiro PRIMARY KEY (CPF)
);

CREATE TABLE Viagem(
	Cod_Viagem INTEGER NOT NULL,
	CPF_Passageiro VARCHAR(11) NOT NULL,
	CONSTRAINT pk_viagem PRIMARY KEY (Cod_Viagem),
	CONSTRAINT fk_viagem_pk_passageiro FOREIGN KEY (CPF_Passageiro)
		REFERENCES Passageiro (CPF)
);

CREATE TABLE Turno(
	Cod_Turno INTEGER NOT NULL,
	Caixa DECIMAL(8,2) NOT NULL,
	CONSTRAINT pk_turno PRIMARY KEY (Cod_Turno)
);

ALTER TABLE Viagem
ADD Cod_Turno INTEGER NOT NULL,
ADD CONSTRAINT fk_viagem_pk_turno FOREIGN KEY (Cod_Turno)
	REFERENCES Turno (Cod_Turno);

CREATE TABLE Linha(
	Numero INTEGER NOT NULL,
	Nome VARCHAR NOT NULL,
	CONSTRAINT pk_linha PRIMARY KEY (Numero)
);

ALTER TABLE Turno
ADD Numero_Linha INTEGER NOT NULL,
ADD CONSTRAINT fk_turno_pk_linha FOREIGN KEY (Numero_Linha)
	REFERENCES Linha (Numero);