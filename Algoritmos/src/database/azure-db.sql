CREATE TABLE administrador (
	id_administrador INT PRIMARY KEY IDENTITY(1,1),
	razao_social VARCHAR(50),
    cnpj VARCHAR(18),
	email VARCHAR(100),
	senha VARCHAR(30),
    telefone VARCHAR(14),
    constraint UN_EmailAdministrador UNIQUE(email)
);

INSERT INTO administrador (razao_social, cnpj, telefone, email, senha) VALUES
    ('maria ltda', '123.456.78/9000-11', '1146764796', 'maria@maria.com','12345678');

select * from administrador;


CREATE TABLE condominio (
    id_condominio INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    cep VARCHAR(9),
    numero VARCHAR(5),
    thumbnail varchar(50),
    id_administrador INT REFERENCES administrador(id_administrador)
);

INSERT INTO condominio(nome, cep,numero, thumbnail, id_administrador)
VALUES ('Residencial das flores', '08535040', '2004', 'condominio001.jpg', 1),
('Conjunto Casa Grande', '08535040', '407', 'condominio002.jpg', 1),
('Conjunto Guanabara', '08502404', '105', 'condominio003.jpg', 1);

CREATE TABLE sensor(
    id_sensor INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    localizacao VARCHAR(50),
    id_condominio INT REFERENCES condominio(id_condominio)
);

insert into sensor(nome, localizacao, id_condominio) 
VALUES('sensor1','primeiro andar/ sala 2',1),('sensor2','primeiro andar/ sala 4',1),('sensor3','segundo andar/ sala 6',1),('sensor4','segundo andar/ sala 8',1),('sensor5','terceiro andar/ sala 10',1),
('sensor6','terceiro andar/ sala 12',1),('sensor7','quarto andar/ sala 14',1),('sensor8','quarto andar/ sala 16',1),('sensor9','quinto andar/ sala 18',1),('sensor10','quinto andar/ sala 20',1),
('sensor1','primeiro andar/ sala 1',2),('sensor2','primeiro andar/ sala 3',2),('sensor3','segundo andar/ sala 5',2),('sensor4','segundo andar/ sala 7',2),('sensor5','terceiro andar/ copa ',2),
('sensor1','primeiro andar/ sala 3',3),('sensor2','segundo andar/ sala 15',3),('sensor3','terceiro andar/ sala 32',3),('sensor4','quarto andar/ sala 56',3),('sensor5','quinto andar/ sala 62',3),
('sensor6','sétimo andar/ sala 76',3),('sensor7','oitavo andar/ sala 88',3),('sensor8','nono andar/ sala 89',3),('sensor9','décimo andar/ sala 101',3),('sensor10','décimo primeiro andar/ copa',3);

CREATE TABLE registro (
    id_registro INT PRIMARY KEY IDENTITY(1,1),
    horario DATETIME,
    pessoas INT,
    id_sensor INT REFERENCES sensor(id_sensor)
);
