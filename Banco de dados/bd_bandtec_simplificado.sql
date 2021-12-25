CREATE DATABASE bd_bandtec2 DEFAULT CHARACTER SET "utf8";
USE bd_bandtec2;

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

-- -----------------------------------------------------
-- Tabela registro
-- -----------------------------------------------------
CREATE TABLE registro(
  id_registro INT NOT NULL auto_increment,
  horario DATE NULL,
  pessoas int NULL,
  id_condominio INT NOT NULL,
  PRIMARY KEY (id_registro, id_condominio),
 CONSTRAINT fk_condominio_registro
    FOREIGN KEY (id_condominio)
    REFERENCES condominio(id_condominio)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

insert into registro values (null, now(), 40, 1);
update registro set pessoas = 41 where id_registro = 1;
