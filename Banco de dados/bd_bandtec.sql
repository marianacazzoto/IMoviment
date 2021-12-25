CREATE DATABASE bd_bandtec DEFAULT CHARACTER SET "utf8";
USE bd_bandtec;

-- -----------------------------------------------------
-- Table administrador
-- -----------------------------------------------------
CREATE TABLE administrador (
  id_administrador INT NOT NULL,
  razao_social VARCHAR(45) NULL,
  cnpj VARCHAR(18) NULL,
  telefone VARCHAR(14) NULL,
  email VARCHAR(45) NULL,
  senha VARCHAR(30) NULL,
  PRIMARY KEY (id_administrador)
);


-- -----------------------------------------------------
-- Tabela condominio
-- -----------------------------------------------------
CREATE TABLE condominio (
  id_condominio INT NOT NULL,
  nome VARCHAR(45) NULL,
  cep VARCHAR(9) NULL,
  numero VARCHAR(5) NULL,
  id_administrador INT NOT NULL,
  PRIMARY KEY (id_condominio, id_administrador),
  CONSTRAINT fk_administrador_condominio
    FOREIGN KEY (id_administrador)
    REFERENCES administrador (id_administrador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Tabela localizacao
-- -----------------------------------------------------
CREATE TABLE localizacao (
  id_localizacao INT NOT NULL,
  nome VARCHAR(45) NULL,
  andar VARCHAR(2) NULL,
  PRIMARY KEY (id_localizacao)
);


-- -----------------------------------------------------
-- Tabela sensor
-- -----------------------------------------------------
CREATE TABLE sensor(
  id_sensor INT NOT NULL,
  id_localizacao INT NOT NULL,
  id_condominio INT NOT NULL,
  PRIMARY KEY (id_sensor, id_condominio),
  CONSTRAINT fk_localizacao_sensor
    FOREIGN KEY (id_localizacao)
    REFERENCES localizacao(id_localizacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_condominio_sensor
    FOREIGN KEY (id_condominio)
    REFERENCES condominio(id_condominio)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Tabela registro
-- -----------------------------------------------------
CREATE TABLE registro(
  id_registro INT NOT NULL,
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