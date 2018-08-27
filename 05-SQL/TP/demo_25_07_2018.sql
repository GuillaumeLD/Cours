create or replace view v_ca_client as 
select year(cde.datecommande) as Annee, clt.numeroClient as 'N° Client',
clt.nomClient as Client, clt.adresseClient as Adresse, 
sum(lcde.quantite*art.prixUnitaire) as ca
from commande cde, lignecommande lcde, article art, client as clt 
where lcde.commande_id=cde.id and lcde.article_id=art.id and cde.client_id=clt.id 
group by annee, numeroclient order by annee, numeroclient;

create or replace view v_ca_total as 
select year(cde.datecommande) as Annee, sum(lcde.quantite*art.prixUnitaire) as ca 
from commande cde, lignecommande lcde, article art
where lcde.commande_id=cde.id and lcde.article_id=art.id  
group by annee order by annee;

---view finale
create or replace view v_ca_finale as 
select v1.*, v2.ca as total ,concat(round((v1.ca/v2.ca)*100,2),' %') as "%"
from v_ca_client v1,v_ca_total v2 
where v1.annee=v2.annee;
+-------+-----------+--------+-----------+-----------+-----------+---------+
| Annee | N° Client | Client | Adresse   | ca        | total     | %       |
+-------+-----------+--------+-----------+-----------+-----------+---------+
|  2017 | CLT0014   | Claude | Clisson   | 4384.8000 | 5744.8000 | 76.33 % |
|  2017 | CLT0015   | Roger  | Rennes    | 1015.0000 | 5744.8000 | 17.67 % |
|  2017 | CLT0032   | Marie  | Marseille |  345.0000 | 5744.8000 | 6.01 %  |
+-------+-----------+--------+-----------+-----------+-----------+---------+

----jointure--
create table a(id int, nom char(2));
create table b(id int, valeur char(2));
insert into a values 
(1,'a'),
(2,'b'),
(3,'c'),
(4,'d');
insert into b values 
(1,'x'),
(3,'y'),
(5,'z'),
(7,'w');
-------cross join--
select * from a cross join b ;
---ou
select * from a, b;
+------+------+------+--------+
| id   | nom  | id   | valeur |
+------+------+------+--------+
|    1 | a    |    1 | x      |
|    2 | b    |    1 | x      |
|    3 | c    |    1 | x      |
|    4 | d    |    1 | x      |
|    1 | a    |    3 | y      |
|    2 | b    |    3 | y      |
|    3 | c    |    3 | y      |
|    4 | d    |    3 | y      |
|    1 | a    |    5 | z      |
|    2 | b    |    5 | z      |
|    3 | c    |    5 | z      |
|    4 | d    |    5 | z      |
|    1 | a    |    7 | w      |
|    2 | b    |    7 | w      |
|    3 | c    |    7 | w      |
|    4 | d    |    7 | w      |
+------+------+------+--------+
16 rows in set (0.00 sec)
------inner join 
select * from a inner join b on a.id=b.id;
---ou
select * from a,b where a.id=b.id;
+------+------+------+--------+
| id   | nom  | id   | valeur |
+------+------+------+--------+
|    1 | a    |    1 | x      |
|    3 | c    |    3 | y      |
+------+------+------+--------+
2 rows in set (0.00 sec)
-----left join--
select * from a left join b on a.id=b.id;
+------+------+------+--------+
| id   | nom  | id   | valeur |
+------+------+------+--------+
|    1 | a    |    1 | x      |
|    3 | c    |    3 | y      |
|    2 | b    | NULL | NULL   |
|    4 | d    | NULL | NULL   |
+------+------+------+--------+


----right join
select * from a right join b on a.id=b.id;
+------+------+------+--------+
| id   | nom  | id   | valeur |
+------+------+------+--------+
|    1 | a    |    1 | x      |
|    3 | c    |    3 | y      |
| NULL | NULL |    5 | z      |
| NULL | NULL |    7 | w      |
+------+------+------+--------+
4 rows in set (0.00 sec)

----coalesce

select a.*, coalesce(b.id,0),coalesce(b.valeur,'Aucune valeur')
 from a left join b on a.id=b.id;
+------+------+------------------+------------------------------------+
| id   | nom  | coalesce(b.id,0) | coalesce(b.valeur,'Aucune valeur') |
+------+------+------------------+------------------------------------+
|    1 | a    |                1 | x                                  |
|    3 | c    |                3 | y                                  |
|    2 | b    |                0 | Aucune valeur                      |
|    4 | d    |                0 | Aucune valeur                      |
+------+------+------------------+------------------------------------+
4 rows in set (0.00 sec)
-------------1ère methode------------
select * from a left join b on a.id=b.id
union 
select * from a right join b on a.id=b.id;
----2ème methode------------
create or replace view v_id as
select id from a 
union
select id from  b;
---
select a.*,b.*
from v_id v left join a on v.id=a.id 
left join b on v.id=b.id;
--
+------+------+------+--------+
| id   | nom  | id   | valeur |
+------+------+------+--------+
|    1 | a    |    1 | x      |
|    3 | c    |    3 | y      |
| NULL | NULL |    5 | z      |
| NULL | NULL |    7 | w      |
|    2 | b    | NULL | NULL   |
|    4 | d    | NULL | NULL   |
+------+------+------+--------+
----correction tp---
---Question n°1
create table fournisseur like client;
create table appro like commande;
create table ligneAppro like ligneCommande;
---Question n°2
alter table fournisseur change numeroClient numeroFournisseur varchar(25);
alter table fournisseur change nomClient niomFournisseur varchar(250);
alter table fournisseur change adresseClient adresseFournisseur varchar(25);
------erreur d'ecriture--
alter table fournisseur modify adresseFournisseur varchar(250) not null;
alter table fournisseur change niomFournisseur nomFournisseur varchar(250);
alter table fournisseur modify numeroFournisseur varchar(25) not null;
alter table fournisseur modify nomFournisseur varchar(250) not null;
-----
alter table appro change numeroCommande numeroAppro varchar(25) not null;
alter table appro change dateCommande  dateAppro timestamp;
alter table appro change client_id fournisseur_id int not null;
alter table appro add foreign key(fournisseur_id) references fournisseur(id);
------
alter table ligneappro change commande_id appro_id int not null;
alter table ligneappro add foreign key(appro_id) references appro(id);
alter table ligneappro add foreign key(article_id) references article(id);
-----------suppression volontaire de la contraite d'integrité sur article_id
alter table ligneAppro drop foreign key ligneappro_ibfk_1;
------------
alter table ligneappro add constraint contrainte_article_id foreign key(article_id) 
references article(id);
------------
alter table ligneappro alter quantite set default 1;
-------Question n°3--
alter table article add prixRevient decimal(12,2) ;
update article set prixRevient=prixUnitaire*0.50;
-----question n° 4 insertion de données
insert into fournisseur values 
(null,'FRS0127','Super-U','Rennes'),
(null,'FRS0128','LeClerc','Nantes'),
(null,'FRS0129','Auchan','Paris');
----
insert into appro values 
(null, 'APPRO0128','2017-01-12',1);

insert into ligneAppro values 
(null,1,1,1145887),
(null,1,2,1240087),
(null,1,3,1254210);
------question n° 5
---view intermediaire--
create or replace view v_stock_intermediaire as 
select l.article_id, l.quantite as appro, 0 vente  from ligneappro l
union all 
select l.article_id, 0 as appro, l.quantite vente  from lignecommande l;
----view stock finale
---creation d'un utilisateur imie
insert into user (user,host,password) values 
('imie','localhost',password('1234'));
flush privileges;
-----ou
create user imie@localhost identified by '1234';
----créer l'utilisateur paul 
create user paul@localhost identified by '1234';
----donner le droit d'afficher numeroArticle et designation à paul 
grant select(numeroArticle,designation) on poei2018.article to paul@localhost;
------donner le droit de supprimer et modifier la table client à paul
grant alter,drop on poei2018.client to paul@localhost
------creer un utilisateur claude qui a le droit d'afficher la table commande
grant select on poei2018.commande to claude@localhost identified by '1234';

-----changer le mot de passe paul en '4321';
set password for paul@localhost=password('4321');

----enlever le droit alter client à claude
revoke select on poei2018.commande from claude@localhost;
-------afficher les droit de paul
show grants for paul@localhost;
-------correction tp---
grant all privileges on article to paul@localhost identified by '1234';
----creation de groupe
create role direction;
create role caisse;
create role depot;
-----------------------
grant all on poei2018.article to direction;
grant all on poei2018.client to direction;
grant select  on poei2018.commande  to direction;
grant select  on poei2018.lignecommande  to direction;
----------------------
grant select  on poei2018.article to caisse;
grant select on poei2018.client to caisse;
grant all  on poei2018.commande  to caisse;
grant all   on poei2018.lignecommande  to caisse;
--------
grant update(prixRevient)  on poei2018.article to depot;
--------
grant direction to rene@localhost identified by '1234', paul@localhost;
grant caisse to claude@localhost identified by '1234', marie@localhost identified by '1234';
grant depot to robert@localhost identified by '1234';
grant direction  to robert@localhost;
--------se connecter en tant que robert au serveur--
mysql -u robert -p poei2018
----activer le groupe direction
set role direction;
-----actiter le groupe depot
set role depot
----desactiver le groupe
set role none;
--detacher robert au groupe depot
revoke depot from robert@localhost;
















































