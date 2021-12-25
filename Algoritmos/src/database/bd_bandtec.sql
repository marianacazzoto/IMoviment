CREATE DATABASE bd_bandtec DEFAULT CHARACTER SET "utf8";
USE bd_bandtec;

-- -----------------------------------------------------
-- Table administrador
-- -----------------------------------------------------
CREATE TABLE administrador (
  id_administrador INT NOT NULL auto_increment,
  razao_social VARCHAR(45) NULL,
  cnpj VARCHAR(18) NULL,
  telefone VARCHAR(14) NULL,
  email VARCHAR(100) unique NULL,
  senha VARCHAR(30) NULL,
  PRIMARY KEY (id_administrador)
);
select * from administrador;
insert administrador values (null, "maria ltda", "123.456.78/9000-11", "1146764796", "maria@maria.com", "12345678");
-- -----------------------------------------------------
-- Tabela condominio
-- -----------------------------------------------------
CREATE TABLE condominio (
  id_condominio INT NOT NULL auto_increment,
  nome VARCHAR(45) NULL,
  cep VARCHAR(9) NULL,
  numero VARCHAR(5) NULL,
  thumbnail varchar(50) null,
  id_administrador INT NOT NULL,
  PRIMARY KEY (id_condominio, id_administrador),
  CONSTRAINT fk_administrador_condominio
    FOREIGN KEY (id_administrador)
    REFERENCES administrador (id_administrador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
select * from administrador;
insert condominio value(null, "Residencial das flores", "08535040", "2004", "condominio001.jpg", 1);
insert condominio value(null, "Conjunto Casa Grande", "08535040", "407", "condominio002.jpg", 1);
insert condominio value(null, "Conjunto Guanabara", "08502404", "105", "condominio003.jpg", 1);

select * from condominio where id_administrador = 1;

select
-- -----------------------------------------------------
-- Tabela localizacao
-- -----------------------------------------------------
CREATE TABLE localizacao (
  id_localizacao INT NOT NULL auto_increment,
  nome VARCHAR(45) NULL,
  andar VARCHAR(2) NULL,
id_condominio INT NOT NULL,
  PRIMARY KEY (id_localizacao, id_condominio),
    CONSTRAINT fk_condominio_sensor
    FOREIGN KEY (id_condominio)
    REFERENCES condominio(id_condominio)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Tabela sensor
-- -----------------------------------------------------
CREATE TABLE sensor(
  id_sensor INT NOT NULL auto_increment,
  id_localizacao INT NOT NULL,
  PRIMARY KEY (id_sensor, id_localizacao),
  CONSTRAINT fk_localizacao_sensor
    FOREIGN KEY (id_localizacao)
    REFERENCES localizacao(id_localizacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Tabela registro
-- -----------------------------------------------------
CREATE TABLE registro(
  id_registro INT NOT NULL auto_increment,
  horario DATETIME NULL,
  ativacao BOOLEAN NULL,
  id_sensor INT NOT NULL,
  PRIMARY KEY (id_registro, id_sensor),
  CONSTRAINT fk_sensor_registro
    FOREIGN KEY (id_sensor)
    REFERENCES sensor(id_sensor)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	temperatura DECIMAL,
	umidade DECIMAL,
	momento DATETIME,
	fk_aquario INT
);
select * from medida;