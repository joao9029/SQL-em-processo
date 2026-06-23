
create database imovelnet ;
use imovelnet;

create table tb_faixa_imovels (
cd_faixa_imovel int primary key unique auto_increment not null,
nm_faixa varchar(30) ,
vl_minimo decimal(14,2) ,
vl_maximo decimal(14,2) 
);
create table tb_estados (
cd_estado int primary key unique auto_increment not null,
nm_estado varchar(50) not null,
sg_estado char(10)
);

create table tb_cidades (
cd_cidade int primary key unique auto_increment not null,
nm_cidade varchar(40) not null,
sg_estado char(10) not null,
id_estado int not null,
foreign key (id_estado) references tb_estados (cd_estado)
);
 
create table tb_bairros (
cd_bairro int primary key unique auto_increment not null,
nm_bairro varchar(30) not null,
id_cidade int,
sg_estado char(10),
foreign key (id_cidade) references tb_cidades (cd_cidade)
);


create table tb_compradores (
cd_comprador int primary key unique auto_increment not null,
nm_comprador varchar(100) not null,
ds_endereco varchar(40) not null,
ds_cpf char(11) unique ,
nm_cidade varchar(30) ,
nm_bairro varchar(30) ,
sg_estado char(10) ,
ds_telefone int ,
ds_email varchar(100) unique
);


create table tb_vendedores (
cd_vendedor int primary key unique auto_increment not null,
nm_vendedor varchar(100) not null,
nm_endereco varchar(40) not null,
ds_cpf char(11) unique,
nm_cidade varchar(20),
nm_bairro varchar(20),
sg_estado char(10),
ds_telefone int ,
ds_email varchar(100) unique 
);

create table tb_imoveis (
cd_imovel int primary key unique auto_increment not null,
id_cidade int,
id_imovel int,
id_bairro int not null,
id_vendedor int ,
sg_estado char(10) ,
nm_endereco varchar(40) not null,
ds_area_util decimal(10,2) not null,
ds_area_total decimal(10,2) not null,
ds_imovel text(300) ,
vl_preco decimal(16,2),
ds_oferta int ,
st_imovel enum('vendido', 'nao_vendido') default 'nao_vendido',
dt_lança datetime,
ds_imovel_indicado int,
id_faixa_imovel int,
foreign key (id_cidade) references tb_cidades (cd_cidade),
foreign key (id_imovel) references tb_imoveis (cd_imovel),
foreign key (id_bairro) references tb_bairros (cd_bairro),
foreign key (id_faixa_imovel) references tb_faixa_imovels (cd_faixa_imovel),
foreign key (id_vendedor) references tb_vendedores (cd_vendedor)
);

create table tb_ofertas (
cd_oferta int primary key unique auto_increment not null,
id_imovel int ,
id_comprador int ,
vl_oferta decimal(16,2),
dt_oferta datetime not null,
foreign key (id_comprador) references tb_compradores (cd_comprador),
foreign key (id_imovel) references tb_imoveis (cd_imovel)
);
alter table tb_cidades
modify id_estado int null;


/* CODIGO DE INDEX*/
create index idx_imovel on tb_imoveis (cd_imovel);
create index idx_estado on tb_imoveis (sg_estado);
create index idx_vendedor on tb_imoveis (id_vendedor);
create index idx_comprador on tb_compradores (nm_comprador asc) ;

/*INCLUINDO ATRIBUTO*/
insert into tb_estados (sg_estado, nm_estado)   
 values ('sp', 'São Paulo'),
       ('rj', 'Rio de Janeiro');

insert into tb_cidades (cd_cidade, nm_cidade, sg_estado)
 values ('1', 'sao paulo', 'sp'),
        ('2','sato andre','sp'),
        ('3','campinas','sp'),
        ('4','rio de janeiro','rj'),
        ('5','niteroi','rj');
        
insert into tb_bairros ( nm_bairro, sg_estado, id_cidade)
values
    ('Jardins', 'sp','1'),
    ('Morumbi','sp','1'),
    ('Aeroporto','sp','1'),
    ('Flamengo','rj','2'),
    ('Copacabana','rj','2');

insert into tb_vendedores (cd_vendedor, nm_vendedor, nm_endereco, ds_email)
values
    (1, 'maria da silva','rua do grito, 45','msilva@novatec.com.br'),
    (2, 'marcos andre','av da saude, 325','mandrade@novatec.com.br'),
    (3, 'andre carboso','av brasil, 401','acardoso@novatec.com.br'),
    (4, 'tatiana souza','rua do impeador, 778','tsouza@novatec.com.br');

insert into tb_imoveis (cd_imovel,id_vendedor,id_bairro,id_cidade,sg_estado,nm_endereco,ds_area_util,ds_area_total,vl_preco,ds_imovel_indicado)
values('1','1','1','1','sp','al tiete, 3304 ap 101','250','400','180000',null),
      ('2','1','2','1','sp','av morumbi, 2230','150','250','135000',1),
      ('3','2','1','1','rj','r gal osorio, 445 ap 34','250','400','185000',2),
	  ('4','2','2','1','rj','r d pedro I, 882','120','200','110000','1'),
      ('5','3','3','1','sp','av rubem berta, 2235','110','200','95000',4),
      ('6','4','1','1','rj','r getulio vargas, 552','200','300','99000',5);

insert into tb_compradores (cd_comprador,nm_comprador,ds_endereco,ds_email)
values  ('1','emmanuel antues','r saraiva, 452','eatunes@novatec.com.br'),
	    ('2','joana pereira','av portugal, 52','jpereira@novatec.com.br'),
        ('3','ronaldo camelo','r estados unidos, 790','rcampelo@novatec.com.br'),
        ('4','manfred augusto','av brasil, 351','maugusto@novatec.com.br');
     
insert into tb_ofertas (id_comprador,id_imovel,vl_oferta,dt_oferta)
values ('1','1','170000','10-01-02'),
	   ('1','3','180000','10-01-02'),
       ('2','2','135000','15-02-02'),
       ('2','4','100000','15-01-02'),
       ('3','1','160000','05-01-02'),
       ('3','2','140000','20-02-02');
   
/*aumentar o valor das coisas*/
update tb_imoveis set  vl_preco = vl_preco*1.10
 where cd_imovel>0; 

update tb_imoveis set id_vendedor = id_vendedor*0.95
where id_vendedor>1;

update tb_ofertas set vl_oferta = vl_oferta * 1.05
WHERE id_comprador = 2;

update tb_compradores set nm_comprador = 'rananas, 45',sg_estado = 'RJ'         
where cd_comprador = 3;

update tb_ofertas set vl_oferta = 101000
where id_comprador = 2 and id_imovel = 4;

/*deletar as coisas*/
delete from tb_ofertas 
where id_comprador = 3 and id_imovel = 1;

delete from tb_cidades 
where cd_cidade = 3 and sg_estado = 'sp';



select * from tb_bairros;


select cd_comprador, nm_comprador, ds_email 
from tb_compradores;


select cd_vendedor, nm_vendedor, ds_email 
from tb_vendedores 
order by nm_vendedor asc;


select cd_vendedor, nm_vendedor, ds_email 
from tb_vendedores 
order by nm_vendedor desc;


select * from tb_bairros 
where sg_estado = 'sp';


select cd_imovel, id_vendedor, vl_preco 
from tb_imoveis 
where id_vendedor = 2;


select cd_imovel, id_vendedor, vl_preco, sg_estado 
from tb_imoveis 
where vl_preco < 150000 
  and sg_estado = 'rj';


select cd_imovel, id_vendedor, vl_preco, sg_estado 
from tb_imoveis 
where vl_preco < 150000 
   or id_vendedor = 1;


select cd_imovel, id_vendedor, vl_preco, sg_estado 
from tb_imoveis 
where vl_preco < 150000 
  and id_vendedor <> 2;


select cd_comprador, nm_comprador, ds_endereco, sg_estado 
from tb_compradores 
where sg_estado is null;


select cd_comprador, nm_comprador, ds_endereco, sg_estado 
from tb_compradores 
where sg_estado is not null;


select * from tb_ofertas 
where vl_oferta between 100000 and 150000;


select * from tb_ofertas 
where dt_oferta between '2002-02-01' and '2002-03-01';


select * from tb_vendedores 
where nm_vendedor like 'm%';


select * from tb_vendedores 
where nm_vendedor like '_a%';


select * from tb_compradores 
where ds_endereco like '%u%';


select * from tb_ofertas 
where id_imovel in (1, 2);


select * from tb_imoveis 
where cd_imovel in (2, 3) 
order by nm_endereco asc;


select * from tb_ofertas 
where id_imovel in (2, 3) 
  and vl_oferta > 140000 
order by dt_oferta desc;


select * from tb_imoveis 
where (vl_preco between 110000 and 200000) 
   or id_vendedor = 1 
order by ds_area_util asc;


select curdate() as data_atual;

select cd_imovel, vl_preco, vl_preco * 1.10 as vl_preco_aumento from tb_imoveis;

select cd_imovel, vl_preco, vl_preco * 1.10 as vl_preco_aumento, (vl_preco * 1.10 - vl_preco) as diferenca from tb_imoveis;

select lower(nm_vendedor) as nmvendedor_minusculo, lower(ds_email) as email_minusculo from tb_vendedores;

select lower(concat(nm_comprador, ' - ', nm_cidade)) as comprador_cidade from tb_compradores;

select lower(nm_comprador) as nm_comprador, ds_endereco, ds_email, lower(nm_cidade) as nm_cidade, lower(nm_bairro) as nm_bairro from tb_compradores where nm_comprador like '%a%';

select lower(left(nm_comprador, 1)) as primeira_letra, lower(nm_bairro) as nm_bairro from tb_compradores;

select id_imovel as cd_imovel, datediff(curdate(), dt_oferta) as dias_desde_oferta from tb_ofertas;

select cd_imovel, dt_lança as dt_lancto, datediff(curdate(), dt_lança) as dias_desde_lancamento from tb_imoveis;

select cd_imovel, dt_lança as dt_lancto, datediff(curdate(), dt_lança) as dias_desde_lancamento, date_add(dt_lança, interval 15 day) as dt_15_dias_depois from tb_imoveis;



/* as 10 questã */

/* 1 */
select 
    i.cd_imovel as cdimovel,
    v.cd_vendedor as cdvendedor,
    v.nm_vendedor as nmvendedor,
    i.sg_estado as sgestado
from tb_imoveis i
join tb_vendedores v on i.id_vendedor = v.cd_vendedor;

/* 2 */
select 
    c.cd_comprador as cdcomprador,
    c.nm_comprador as nmcomprador,
    o.id_imovel as cdimovel,
    o.vl_oferta as vloferta
from tb_compradores c
join tb_ofertas o on c.cd_comprador = o.id_comprador;

/* 3 */
select 
    i.cd_imovel as cdimovel,
    i.vl_preco as vlpreco,
    b.nm_bairro as nmbairro
from tb_imoveis i
join tb_bairros b on i.id_bairro = b.cd_bairro
where i.id_vendedor = 3;

/* 4 */
select distinct 
    i.cd_imovel,
    i.nm_endereco,
    i.vl_preco
from tb_imoveis i
join tb_ofertas o on i.cd_imovel = o.id_imovel;

/* 5 */
select 
    i.cd_imovel,
    i.nm_endereco,
    o.vl_oferta,
    o.dt_oferta
from tb_imoveis i
left join tb_ofertas o on i.cd_imovel = o.id_imovel
order by i.cd_imovel;

/* 6 */
select 
    c.cd_comprador,
    c.nm_comprador,
    o.id_imovel,
    o.vl_oferta,
    o.dt_oferta
from tb_compradores c
join tb_ofertas o on c.cd_comprador = o.id_comprador;

/* 7 */
select 
    c.cd_comprador,
    c.nm_comprador,
    o.id_imovel,
    o.vl_oferta,
    o.dt_oferta
from tb_compradores c
left join tb_ofertas o on c.cd_comprador = o.id_comprador
order by c.cd_comprador;

/* 8 */
select 
    i.nm_endereco as endereco_imovel,
    ii.nm_endereco as endereco_imovel_indicado
from tb_imoveis i
left join tb_imoveis ii on i.ds_imovel_indicado = ii.cd_imovel;

/* 9 */
select 
    i.nm_endereco as endereco_imovel,
    v.nm_vendedor as vendedor_do_imovel,
    ii.nm_endereco as endereco_imovel_indicado,
    vi.nm_vendedor as vendedor_do_imovel_indicado
from tb_imoveis i
left join tb_vendedores v on i.id_vendedor = v.cd_vendedor
left join tb_imoveis ii on i.ds_imovel_indicado = ii.cd_imovel
left join tb_vendedores vi on ii.id_vendedor = vi.cd_vendedor;

/* 10 */
select 
    i.nm_endereco as endereco_imovel,
    b.nm_bairro as bairro,
    f.nm_faixa as nivel_preco
from tb_imoveis i
join tb_bairros b on i.id_bairro = b.cd_bairro
left join tb_faixa_imovels f on i.id_faixa_imovel = f.cd_faixa_imovel;



-- 1. Maior, menor e média das ofertas
select 
    max(vl_oferta) as maior_oferta,
    min(vl_oferta) as menor_oferta,
    avg(vl_oferta) as media_oferta
from tb_ofertas;

-- 2. Desvio-padrão e variância do preço dos imóveis
select 
    stddev(vl_preco) as desvio_padrao,
    variance(vl_preco) as variancia
from tb_imoveis;

-- 3. Desvio-padrão e variância com 2 casas decimais
select 
    round(stddev(vl_preco), 2) as desvio_padrao,
    round(variance(vl_preco), 2) as variancia
from tb_imoveis;

-- 4. Maior, menor, total e média de preço dos imóveis
select 
    max(vl_preco) as maior_preco,
    min(vl_preco) as menor_preco,
    sum(vl_preco) as total_preco,
    avg(vl_preco) as media_preco
from tb_imoveis;

-- 5. Estatísticas de preço por bairro
select 
    b.nm_bairro,
    max(i.vl_preco) as maior_preco,
    min(i.vl_preco) as menor_preco,
    sum(i.vl_preco) as total_preco,
    avg(i.vl_preco) as media_preco
from tb_imoveis i
join tb_bairros b on i.id_bairro = b.cd_bairro
group by b.nm_bairro;

-- 6. Total de imóveis por vendedor (ordenado)
select 
    v.cd_vendedor,
    v.nm_vendedor,
    count(i.cd_imovel) as total_imoveis
from tb_vendedores v
left join tb_imoveis i on v.cd_vendedor = i.id_vendedor
group by v.cd_vendedor, v.nm_vendedor
order by total_imoveis desc;

-- 7. Diferença entre o imóvel mais caro e o mais barato
select 
    max(vl_preco) - min(vl_preco) as diferenca_precos
from tb_imoveis;

-- 8. Menor preço por vendedor (acima de 10 mil)
select 
    id_vendedor,
    min(vl_preco) as menor_preco
from tb_imoveis
where vl_preco >= 10000
group by id_vendedor;

-- 9. Média e quantidade de ofertas por comprador
select 
    c.cd_comprador,
    c.nm_comprador,
    avg(o.vl_oferta) as media_ofertas,
    count(o.cd_oferta) as numero_ofertas
from tb_compradores c
left join tb_ofertas o on c.cd_comprador = o.id_comprador
group by c.cd_comprador, c.nm_comprador;

-- 10. Total de ofertas por ano (2000, 2001 e 2002)
select 
    year(dt_oferta) as ano,
    count(cd_oferta) as total_ofertas
from tb_ofertas
where year(dt_oferta) in (2000, 2001, 2002)
group by year(dt_oferta)
order by ano;

select * from tb_imoveis
where id_bairro = (select id_bairro from tb_imoveis where cd_imovel = 2)
and cd_imovel <> 2;
select * from tb_imoveis
where vl_preco > (select avg(vl_preco) from tb_imoveis);
select distinct c.*
from tb_compradores c
join tb_ofertas o on c.cd_comprador = o.id_comprador
where o.vl_oferta > 70000;
select distinct i.*
from tb_imoveis i
join tb_ofertas o on i.cd_imovel = o.id_imovel
where o.vl_oferta > (select avg(vl_oferta) from tb_ofertas);
select * from tb_imoveis i

where vl_preco > (select avg(vl_preco)
from tb_imoveis i2
where i2.id_bairro = i.id_bairro);
select * from tb_imoveis i

where (id_bairro, vl_preco) in (
select id_bairro, max(vl_preco)
from tb_imoveis
group by id_bairro
having max(vl_preco) > (select avg(vl_preco) from tb_imoveis)
);

select * from tb_imoveis i

where vl_preco = (select min(vl_preco)
from tb_imoveis i2
where i2.id_vendedor = i.id_vendedor);

select o.*
from tb_ofertas o
join tb_imoveis i on o.id_imovel = i.cd_imovel
where i.id_vendedor = 2

and (datediff(curdate(), i.dt_lança) < 30
or datediff(curdate(), i.dt_lança) > 180);

select * from tb_ofertas o

where vl_oferta < all (select vl_oferta
from tb_ofertas
where id_comprador = 2)
and id_comprador <> 2;

select * from tb_imoveis i
where (sg_estado, id_cidade) = (select sg_estado, id_cidade
from tb_imoveis
where id_vendedor = 3
limit 1)

and id_vendedor <> 3;
select distinct b.nm_bairro
from tb_bairros b
join tb_imoveis i on b.cd_bairro = i.id_bairro

where (i.sg_estado, i.id_cidade, i.id_bairro) = (
select sg_estado, id_cidade, id_bairro
from tb_imoveis
where cd_imovel = 5
);