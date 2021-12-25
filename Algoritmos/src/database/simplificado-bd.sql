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
insert condominio value(1, "Residencial das flores", "08535040", "2004", "condominio001.jpg", 1);
insert condominio value(2, "Conjunto Casa Grande", "08535040", "407", "condominio002.jpg", 1);
insert condominio value(3, "Conjunto Guanabara", "08502404", "105", "condominio003.jpg", 1);


select * from condominio;

create table sensor(
	id_sensor int auto_increment,
    nome varchar(50),
    localizacao varchar(80),
    id_condominio int not null,
    primary key (id_sensor, id_condominio),
    constraint fk_condominio_sensor 
    foreign key(id_condominio) references condominio(id_condominio)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

insert into sensor (nome, localizacao, id_condominio) values
("sensor1","primeiro andar/ sala 2",1),("sensor2","primeiro andar/ sala 4",1),("sensor3","segundo andar/ sala 6",1),("sensor4","segundo andar/ sala 8",1),("sensor5","terceiro andar/ sala 10",1),
("sensor6","terceiro andar/ sala 12",1),("sensor7","quarto andar/ sala 14",1),("sensor8","quarto andar/ sala 16",1),("sensor9","quinto andar/ sala 18",1),("sensor10","quinto andar/ sala 20",1),
("sensor1","primeiro andar/ sala 1",2),("sensor2","primeiro andar/ sala 3",2),("sensor3","segundo andar/ sala 5",2),("sensor4","segundo andar/ sala 7",2),("sensor5","terceiro andar/ copa ",2),
("sensor1","primeiro andar/ sala 3",3),("sensor2","segundo andar/ sala 15",3),("sensor3","terceiro andar/ sala 32",3),("sensor4","quarto andar/ sala 56",3),("sensor5","quinto andar/ sala 62",3),
("sensor6","sétimo andar/ sala 76",3),("sensor7","oitavo andar/ sala 88",3),("sensor8","nono andar/ sala 89",3),("sensor9","décimo andar/ sala 101",3),("sensor10","décimo primeiro andar/ copa",3);


select * from sensor;
-- -----------------------------------------------------
-- Tabela registro
-- -----------------------------------------------------
CREATE TABLE registro(
  id_registro INT NOT NULL auto_increment,
  horario DATETIME NULL,
  pessoas int NULL,
  id_sensor INT NOT NULL,
  PRIMARY KEY (id_registro, id_sensor),
	CONSTRAINT fk_sensor_registro
    FOREIGN KEY (id_sensor)
    REFERENCES sensor(id_sensor)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

select * from registro;

insert into registro values (null, now(), 40, 1);
insert into registro (horario, pessoas, id_condominio) values (time('06:59'), 50, 2);
insert into registro (horario, pessoas, id_condominio) values ("2021-11-25 17:00", 50, 2);
insert into registro (horario, pessoas, id_condominio) values (now(), 50, 2);
update registro set pessoas = 41 where id_registro = 1;
select sum(pessoas) from registro group by(horario);
select * from condominio;
delete from condominio where id_condominio = 7;




select horario, sum(pessoas) from registro  group by(horario);
select sum(pessoas) from registro where horario > "2021-11-24 06:00" and horario < "2021-11-24 09:00";
select  sum(pessoas) from registro where horario > time("09:00") and horario < time("12:00") ;
select  sum(pessoas) from registro where horario > "2021-11-24 12:00" and horario < "2021-11-24 15:00" ;
select  sum(pessoas) from registro where horario > time("15:00") and horario < time("18:00") ;
select  sum(pessoas) from registro where horario > time("18:00") and horario < time("21:00") ;
select  hour(horario), sum(pessoas) as contagem from registro where horario = date('2021-11-25') group by(hour(horario));
select date("2021-11-24") from registro;

select hour(horario) as horario, sum(pessoas) as pessoas from registro where id_condominio = 2 and date(horario) = ('2021-11-25') group by(hour(horario)) order by(horario);

insert into registro (horario, pessoas, id_condominio) values ('2021-11-24 06:50', 50, 2);

insert into registro (horario, pessoas, id_condominio) values ('2021-11-24 08:47', 50, 2);

insert into registro (horario, pessoas, id_condominio) values ('2021-11-24 12:47', 50, 2);
use bd_bandtec2;

select * from registro;
select id_condominio,  hour(horario) as horario, sum(pessoas) as pessoas from registro where date(horario) = ('2021-11-2') group by(hour(horario)) order by(horario);

select DATE_FORMAT(horario, "%a") as horario, sum(pessoas) as pessoas from registro where id_condominio = 2 group by date(horario) order by date(horario) desc limit 8;
select * from registro where id_condominio = 3;
SELECT DATE_FORMAT(t1.horario, '%a') as horario, t1.pessoas as pessoas FROM (select horario, pessoas from registro as re where id_condominio = 2 group by date(horario) order by date(horario) desc limit 8) as t1 ORDER BY t1.horario;

select id_condominio, (pessoas), horario from registro group by id_condominio;