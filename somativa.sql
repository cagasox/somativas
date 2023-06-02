use formativaHogwarts;

create table usuarios(
	id bigint not null auto_increment,
    nome varchar(150) not null,
    email varchar(100) not null,
    dataNascimento date not null,
    senha varchar(50) not null,
    dataCadastro datetime default now(),
    status boolean default true,
	foto_url varchar(150),
    phone varchar(11),
	ocupacaoFK bigint not null,
    primary key(id),
    foreign key(ocupacaoFK) references ocupacao(id)
);

select *from usuarios;
insert into usuarios (phone) values ('19982744837'),('19992745837'),('19982745865'),('19982745834'),('19982745887'),('19948745437');

create table fotos_tarefas(
id bigint not null auto_increment,
fotos_solicitaçoes varchar(150),
primary key (id)
);

select *from fotos_tarefas;
insert into fotos_tarefas (fotos_solicitaçoes) values ('foto cabo'),('foto monitor '),('foto projetor '),('foto maçaneta'),('foto cadeira '),('foto teclado');

create table responsavel (
id bigint not null auto_increment,
usuarioFK bigint not null,
primary key (id),
foreign key (usuarioFK) references usuarios(id)
);

select *from responsavel;
insert into responsavel (usuarioFK) values ('1'),('2'),('3'),('5'),('6');

create table status_tarefas (
id bigint not null auto_increment,
etapa boolean,
atualizacao datetime default now(),
descricao varchar (300),
fotostatus varchar(150),
primary key (id)
);

select *from status_tarefas;

create table pogresso(
id bigint not null auto_increment,
nome_do_processo varchar(50),
primary key (id)
);

select *from pogresso;

create table tarefas(
id bigint not null auto_increment,
nome_da_tarefa varchar (100),
descriçao varchar (500),
data_de_inicio datetime default now(),
data_de_fim datetime,
prazo_execucao datetime,
localFK bigint  not null,
responsavelFK bigint not null,
statusFK bigint not null,
fotos_tarefasFK bigint not null,
progressoFK bigint not null,
usuaririosFK bigint not null,
primary key (id),
foreign key (localFK) references locais(id),
foreign key (responsavelFK) references responsavel(id),
foreign key (statusFk) references status_tarefas(id),
foreign key (fotos_tarefasFK) references fotos_tarefas(id),
foreign key (progressoFK) references pogresso (id),
foreign key (usuaririosFK) references usuarios(id)
);

select *from tarefas;
/*Crie uma consulta que mostre todas as tarefas ainda não iniciadas com as informações de seus  respectivos envolvidos no processo*/
select *from tarefas where progressoFK <2;
select *from pogresso;

/*Crie uma consulta que mostre todos os locais que tiveram associação a mais de duas tarefas*/
select distinct t.id, t.nome_da_tarefa from tarefas t
inner join locais l on t.localFK = l.id;

select t.id, t.nome_da_tarefa from tarefas t where 
t.localFK >1 in(select t.id from tarefas t);

/*Crie uma consulta que mostre todos os usuários que tiveram associação a duas tarefas no mínimo*/
select *from tarefas where localFK >2 ;

