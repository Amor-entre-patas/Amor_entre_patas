create database AmorEntrePatas;
use AmorEntrePatas;

create table Usuario (
id_usuario int primary key auto_increment,
nome varchar(45),
email varchar(45),
cpf char(11),
senha_hash varchar(255),
dt_cadastro date
);

create table Ong(
id_ong int primary key auto_increment,
nome varchar(45),
descricao varchar(150),
email varchar(45)
);

create table Categoria (
id_categoria int primary key auto_increment,
nome_categoria varchar(45),
pontuacao_maxima int
);

create table Quiz (
id_quiz int primary key auto_increment,
pergunta varchar(100),
fk_categoria int,
 CONSTRAINT fk_quiz_categoria FOREIGN KEY (fk_categoria) REFERENCES Categoria(id_categoria)
);

create table Alternativa (
id_alternativa_letra int primary key auto_increment,
texto_alternativa varchar(100),
pontuacao_alternativa int,
fk_quiz int,
constraint ckFkQuiz foreign key(fk_quiz) references Quiz(id_quiz)
);

create table Resultado_quiz (
id_resultado_quiz int primary key auto_increment,
dt_realizacao date,
classificacao varchar (50),
fk_usuario int,
fk_quiz int,
constraint ckFkUsuarios foreign key(fk_usuario) references Usuario(id_usuario),
constraint ckFkQuiiz foreign key (fk_quiz) references Quiz(id_quiz)
);

create table Animal (
id_animal int primary key auto_increment,
nome varchar(45),
especie varchar (45),
dt_nasc date,
fk_ong int,
constraint ckFkOng foreign key(fk_ong) references Ong(id_ong)
);

create table Interesse_adoacao (
fk_animal int,
fk_usuario int,
PRIMARY KEY (fk_animal, fk_usuario),
constraint ckFkanimal foreign key(fk_animal) references Animal(id_animal),
constraint ckFkUsuarioAdocao foreign key(fk_usuario) references Usuario (id_usuario)
);

create table Statuss (
id_statuss int primary key auto_increment,
email varchar(45),
atualmente varchar (45),
fk_usuario int,
constraint chk_atualmente check(atualmente in ('Aprovado', 'Em analise', 'Negado')),
constraint ckFkUsuarioss foreign key (fk_usuario) references Usuario (id_usuario)
);

create table Historias (
id_historias int primary key auto_increment,
historia varchar (7000),
fk_statuss int,
fk_usuario int,
constraint ckFkStatuss foreign key (fk_statuss) references Statuss(id_statuss),
constraint ckFkUsuarioos foreign key (fk_usuario) references Usuario(id_usuario)
);


CREATE TABLE Pontuacao (
    fk_resultado_quiz INT,
    fk_categoria INT,
    pontuacao_obtida INT,
   PRIMARY KEY (fk_resultado_quiz, fk_categoria),
   FOREIGN KEY (fk_resultado_quiz) REFERENCES Resultado_quiz(id_resultado_quiz),
   FOREIGN KEY (fk_categoria) REFERENCES Categoria(id_categoria)
);


INSERT INTO Ong (nome, descricao, email) VALUES
('Ajuda animal', 'Ong voltado para adoção de aniais de estimação no geral', '@ajudaanimal'),
('Cat land', 'Ong voltada para adoção de gatos', '@catland');

insert into Categoria (nome_categoria, pontuacao_maxima) values 
('Tempo', 20),
('Custo', 20),
('Espaço', 20),
('Responsabilidade', 20),
('Preparo', 20);

-- QUIZ
INSERT INTO Quiz (pergunta, fk_categoria) VALUES
('Quantas vezes por semana você consegue passear com o animal?', 1),
('Quanto tempo por dia você passa em casa com ele?', 1),
('Quanto você consegue reservar por mês para ração, banho e cuidados do dia a dia?', 2),
('Se ele ficar doente, como você lidaria com a consulta e o tratamento?', 2),
('Como é o lugar onde ele vai morar?', 3),
('Onde ele vai dormir e descansar?', 3),
('Quem vai cuidar dele no dia a dia?', 4),
('Se você precisar viajar por alguns dias, o que acontece com ele?', 4),
('Você já pesquisou sobre o porte do animal e a rotina de cuidados dele?', 5),
('Cães e gatos podem viver de 10 a 20 anos. Como você se sente quanto a isso?', 5);


-- Alternativa
insert into Alternativa (texto_alternativa, pontuacao_alternativa, fk_quiz) values 
('1 vez por semana ou menos', 1, 1),
('2 a 3 vezes por semana', 4, 1),
('Todos os dias', 10, 1),
('4 a 5 vezes por semana', 7, 1),

('De 2 a 4 horas', 4, 2),
('Mais de 6 horas', 10, 2),
('Menos de 2 horas', 1, 2),
('De 4 a 6 horas', 7, 2),

('Só o básico', 4, 3),
('Ainda não calculei', 1, 3),
('O suficiente, mas apertado', 7, 3),
('O suficiente, com folga', 10, 3),

('Dependeria da ajuda de familiares', 4, 4),
('Tenho uma reserva ou plano para isso', 10 , 4),
('Não teria como pagar agora', 1, 4),
('Conseguiria pagar parcelando', 7, 4),

('Apartamento pequeno, sem telas nas janelas', 1, 5),
('Casa com quintal e área segura', 10, 5),
('Apartamento grande, com telas nas janelas', 7, 5),
('Apartamento pequeno, com telas nas janelas', 4, 5),

('Em uma área externa coberta', 4, 6),
('Em um espaço compartilhado dentro de casa', 7, 6),
('Ainda não decidi', 1, 6),
('Em um cantinho só dele, dentro de casa', 10, 6),

('Eu sozinho(a)', 7, 7),
('Dividido com a família, mas sem combinar tarefas', 4, 7),
('Eu, com ajuda combinada da família', 10, 7),
('Ainda não definimos', 1, 7),

('Pediria a algum conhecido na hora', 7, 8),
('Nunca pensei nisso', 1, 8),
('Já tenho alguém de confiança ou um hotelzinho em mente', 10, 8),
('Levaria comigo, se desse', 4, 8),

('Pesquisei um pouco', 4, 9),
('Sim, e conversei com a ONG', 10, 9),
('Ainda não pesquisei', 1, 9),
('Pesquisei bastante', 7, 9),

('Estou ciente e disposto(a)', 7, 10),
('Não tinha pensado nisso', 1, 10),
('Preciso pensar melhor', 4, 10),
('Já me planejei para esse tempo todo', 10, 10);

-- ANIMAIS
INSERT INTO Animal (nome, especie, dt_nasc, fk_ong) VALUES
('Azevinho', 'Cachorro', '2026-07-21', 1),
('Hantu', 'Gato', '2025-02-11', 2),
('Bôrbí', 'Cachorro', '2023-05-30', 1);

insert into Usuario (nome, email, cpf, senha_hash, dt_cadastro) values 
('Gabriela', 'Gabriela@email', '12345678901', sha1('ZeusFofo12'), '2026-11-24'),
('Marina', 'Marina@email', '12345678987', sha1('AmoraLinda04'), '2026-1-4'),
('Júlia', 'Júlia@email', '12345678956', sha1('Lunacutepie56'), '2026-7-13'),
('Kaique', 'Kaique@email', '12345678923', sha1('PirilampoPapagaio'), '2026-3-2');


insert into Statuss (email, atualmente, fk_usuario) values 
('Gabriela@email', 'Aprovado', 1),
('Marina@email', 'Aprovado', 2),
('Júlia@email', 'Aprovado', 3),
('Kaique@email', 'Aprovado', 4);


INSERT INTO Historias (historia, fk_statuss, fk_usuario) VALUES
('Minha história com Zeus começou quando a gata da minha madrinha teve filhotes.\nMeu pai ficou encantado por ele desde o primeiro momento, dizia o tempo todo o quanto era lindo e insistiu para que eu fosse conhecê-lo. E não deu outra: como toda boa criança, me apaixonei e decidi que queria adotá-lo. Foi assim que Zeus chegou à minha vida!\nCom o passar do tempo, Zeus desenvolveu uma personalidade um tanto quanto intensa. É um gato estressadinho, de pavio curto e nem sempre muito paciente. Mas, apesar disso, sua beleza conquista qualquer pessoa que cruza seu caminho. Mesmo não sendo o gato mais carinhoso do mundo, tem seu jeitinho próprio e singelo de demonstrar afeto.\nTalvez Zeus não seja daqueles gatos que vivem pedindo colo ou carinho, mas isso não significa que sua presença seja menos especial. A simples companhia dele já faz toda a diferença e consegue melhorar meus dias. Afinal, aprendi que o amor também está nos pequenos gestos e na companhia silenciosa de quem faz parte da nossa vida.', 1, 1),

('A Amora apareceu em nossas vidas em uma situação muito delicada.\nNós a encontramos na rua e, ao percebermos que ela precisava de ajuda, minha mãe e eu decidimos tentar acolhê-la. Durante esse processo, descobrimos que uma mulher dizia ser responsável por ela. Depois de conversarmos e conseguirmos sua autorização, finalmente pudemos levar a Amora para casa.\nAos poucos, ela foi conquistando um espaço muito especial em nossos corações. Queríamos oferecer a ela todo o carinho, cuidado e segurança que merecia. Mas, infelizmente, um dia a Amora acabou fugindo e se perdeu.\nDesde então, ficou a saudade e a esperança de que ela esteja bem. Mesmo com tudo o que aconteceu, sua passagem por nossas vidas deixou lembranças que nunca vamos esquecer. A Amora nos ensinou que acolher um animal é também criar um vínculo que permanece, independentemente do tempo.', 2, 2),

('A Luna chegou até nós de uma maneira inesperada. Ela foi encontrada dentro de uma caixa de papelão, em uma situação em que precisava muito de cuidado e proteção. Quando soubemos de sua história, não conseguimos ignorar aquela pequena vida que precisava de uma oportunidade.\nDecidimos acolhê-la e dar a ela a chance de conhecer algo diferente: um lar, uma família e todo o carinho que um animal merece receber. Com seus dois olhinhos azuis, a Luna foi conquistando seu espaço e transformando nossos dias.\nHoje, olhar para ela é lembrar de como um simples gesto de acolhimento pode mudar completamente o destino de um animal. A Luna não encontrou apenas um lugar para ficar, encontrou uma família. E nós encontramos nela uma companheira muito especial.', 3, 3),

('Há cerca de 30 anos, Pirilampo foi encontrado com uma das asas cortadas. Precisando de cuidados, ele ganhou uma nova oportunidade quando chegou à nossa família, que decidiu acolhê-lo e oferecer um lar cheio de carinho.\nPirilampo não foi o único a encontrar uma segunda chance por aqui. Nossa casa também é lar de Paçoca, Pitaya e Atum, cada um com sua própria história de adoção. Todos chegaram precisando de algum tipo de cuidado, e tivemos a oportunidade de fazer a diferença na vida de cada um.\nHoje, depois de três décadas, não consigo imaginar minha casa sem a presença do Pirilampo e dos outros animais. Brinquedos, pelos e penas já fazem parte da nossa rotina e das nossas lembranças. Afinal, adotar não transforma apenas a vida de um animal, mas também a de quem escolhe acolhê-lo.', 4, 4);





-- SELECTS --

-- 1 Preparo geral --

SELECT
    SUM(p.pontuacao_obtida) AS pontuacao_total,
    SUM(c.pontuacao_maxima) AS pontuacao_maxima,
    (SUM(p.pontuacao_obtida) / SUM(c.pontuacao_maxima)) * 100 AS preparo_geral
FROM Pontuacao p
JOIN Categoria c
    ON p.fk_categoria = c.id_categoria
WHERE p.fk_resultado_quiz = 1;

-- 2 Área de destaque -- 

SELECT
    c.nome_categoria,
    p.pontuacao_obtida
FROM Pontuacao p
JOIN Categoria c
    ON p.fk_categoria = c.id_categoria
WHERE p.fk_resultado_quiz = 1
ORDER BY p.pontuacao_obtida DESC
LIMIT 1;

-- 3 Atenção necessária --

SELECT
    c.nome_categoria,
    p.pontuacao_obtida
FROM Pontuacao p
JOIN Categoria c
    ON p.fk_categoria = c.id_categoria
WHERE p.fk_resultado_quiz = 1
ORDER BY p.pontuacao_obtida ASC
LIMIT 1;

-- 4 Você x média --

SELECT
    (SELECT SUM(pontuacao_obtida)
     FROM Pontuacao
     WHERE fk_resultado_quiz = 1) AS sua_pontuacao,

    (SELECT AVG(total_pontos)
     FROM (
         SELECT
             fk_resultado_quiz,
             SUM(pontuacao_obtida) AS total_pontos
         FROM Pontuacao
         GROUP BY fk_resultado_quiz
     ) AS resultados) AS media_usuarios,

    (SELECT SUM(pontuacao_obtida)
     FROM Pontuacao
     WHERE fk_resultado_quiz = 1)
    -
    (SELECT AVG(total_pontos)
     FROM (
         SELECT
             fk_resultado_quiz,
             SUM(pontuacao_obtida) AS total_pontos
         FROM Pontuacao
         GROUP BY fk_resultado_quiz
     ) AS resultados) AS diferenca;
