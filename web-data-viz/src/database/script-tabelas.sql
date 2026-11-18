create database AmorEntrePatas;
use AmorEntrePatas;

create table usuario (
id_usuario int primary key auto_increment,
nome varchar(45),
email varchar(45),
cpf char(11),
senha varchar(45),
dt_cadastro date
);

create table ong(
id_ong int primary key auto_increment,
nome varchar(45),
descricao varchar(45),
email varchar(45)
);


create table Quiz (
id_quiz int primary key auto_increment,
pergunta varchar(45),
alternativa_a varchar(45),
alternativa_b varchar(45),
alternativa_c varchar(45),
alternativa_d varchar(45)
);


create table Codigo_Validacao (
id_codigo_validacao int primary key auto_increment,
codigo int,
utilizado tinyint,
fk_usuario int,
constraint ckFkUsuario foreign key(fk_usuario) references usuario(id_usuario)
);

create table Resultado_quiz (
id_resultado_quiz int primary key auto_increment,
pontuacao int,
classificacao varchar(45),
dt_realizacao date,
fk_usuario int,
fk_quiz int,
constraint ckFkUsuarios foreign key(fk_usuario) references usuario(id_usuario),
constraint ckFkQuiz foreign key (fk_quiz) references Quiz(id_quiz)
);

create table animal (
id_animal int primary key auto_increment,
nome varchar(45),
especie varchar (45),
idade int,
fk_ong int,
constraint ckFkOng foreign key(fk_ong) references ong(id_ong)
);

create table interesse_adoacao (
id_interesse_adoacao int primary key auto_increment,
fk_animal int,
fk_usuario int,
constraint ckFkanimal foreign key(fk_animal) references animal(id_animal),
constraint ckFkUsuarioAdocao foreign key(fk_usuario) references usuario (id_usuario)
);


INSERT INTO usuario (nome, email, cpf, senha, dt_cadastro) VALUES
('Ana', 'ana@email.com', '12345678901', 'senha123', '2026-11-10'),
('Pedro', 'pedro@email.com', '23456789012', 'senha456', '2026-11-11'),
('Mariana', 'mariana@email.com', '34567890123', 'senha789', '2026-11-12'),
('Lucas', 'lucas@email.com', '45678901234', 'senha321', '2026-11-13');

INSERT INTO ong (nome, descricao, email) VALUES
('Proteção Animal Resgate', 'Realiza eventos de adoção e conecta animais a novas famílias.', '@protecaoanimalresgate'),
('Instituto caramelo', 'Resgate e reabilitação de cães e gatos para adoção responsável.', '@Institutocaramelo'),
('ONG azul', 'Apoio a protetores e adoção de animais resgatados.', '@ongazul');

-- QUIZ
INSERT INTO Quiz (pergunta, alternativa_a, alternativa_b, alternativa_c, alternativa_d) VALUES
('Voce tem tempo para um animal?', 'Sim, bastante', 'Preciso me organizar', 'Tenho pouco tempo', 'Nao tenho tempo'),
('Pode arcar com os custos?', 'Sim, tranquilamente', 'Com planejamento', 'Tenho dificuldades', 'Nao posso no momento'),
('Todos em casa concordam?', 'Sim, todos', 'A maioria', 'Ainda preciso conversar', 'Nao concordam'),
('Tem espaco adequado?', 'Sim, suficiente', 'Preciso adaptar', 'Tenho pouco espaco', 'Nao tenho');

-- CODIGO DE VALIDACAO
INSERT INTO Codigo_Validacao (codigo, utilizado, fk_usuario) VALUES
(123456, 1, 1),
(234567, 1, 2),
(345678, 0, 3),
(456789, 0, 4);

-- RESULTADO DO QUIZ
INSERT INTO Resultado_quiz (pontuacao, classificacao, dt_realizacao, fk_usuario, fk_quiz) VALUES
(10, 'Preparado', '2026-11-12', 1, 1),
(7, 'Em preparacao', '2026-11-12', 2, 2),
(5, 'Precisa se informar mais', '2026-11-13', 3, 3),
(9, 'Preparado', '2026-11-14', 4, 4);

-- ANIMAIS
INSERT INTO animal (nome, especie, idade, fk_ong) VALUES
('Bolinha', 'Cachorro', 2, 1),
('Mimi', 'Gato', 1, 1),
('Thor', 'Cachorro', 4, 2),
('Luna', 'Gato', 3, 2),
('Pipoca', 'Coelho', 1, 3),
('Mel', 'Cachorro', 5, 3);

-- INTERESSES EM ADOCAO
INSERT INTO interesse_adoacao (fk_animal, fk_usuario) VALUES
(1, 1),
(2, 2),
(3, 1),
(5, 3),
(6, 4);





