-- Se connecter en mysql
mysql -u root
-- Afficher les noms des différentes bdd
show databases;
-- Créer une bdd poei2018
create database poei2018;
-- Se connecter à la bdd poei2018
use poei2018;
-- créer la table article
create table article(id int auto_increment primary key, numeroArticle varchar(25) unique not null, designation varchar(250) not null, prixUnitaire decimal(12,2) not null);
-- insertion de données à la table article
insert into article(numeroArticle, designation, prixUnitaire) values ('BB001','Bière Castel 350ml',3.50),
																		('BJ001','Jus d''ananas 1.5L',2.50),
																		('EL020','Multiprise électrique',7.20),
																		('AM012','Huile moteur 40w10 2L',5.20),
																		('XX032','Riz Basmati 25kg',25.20);
-- Afficher le contenu de la table article
/* select * from article;
+----+---------------+-----------------------+--------------+
| id | numeroArticle | designation           | prixUnitaire |
+----+---------------+-----------------------+--------------+
|  1 | BB001         | Bière Castel 350ml    |         3.50 |
|  2 | BJ001         | Jus d'ananas 1.5L     |         2.50 |
|  3 | EL020         | Multiprise électrique |         7.20 |
|  4 | AM012         | Huile moteur 40w10 2L |         5.20 |
|  5 | XX032         | Riz Basmati 25kg      |        25.20 |
+----+---------------+-----------------------+--------------+ */

-- Afficher seulement les colonnes numeroArticle et prixUnitaire
/* select numeroArticle, prixUnitaire from article;
+---------------+--------------+
| numeroArticle | prixUnitaire |
+---------------+--------------+
| BB001         |         3.50 |
| BJ001         |         2.50 |
| EL020         |         7.20 |
| AM012         |         5.20 |
| XX032         |        25.20 |
+---------------+--------------+
5 rows in set (0.00 sec) */

-- Afficher l'article dont id=1;
select * from article where id=1;
-- Afficher les articles dont le numero article commence par B
select * from article where numeroArticle like 'B%';
-- Afficher les articles dont la désignation contient la lettre 'a'
select * from article where designation like '%a%';
-- Afficher la structure de la table article
desc article;
/* +---------------+---------------+------+-----+---------+----------------+
| Field         | Type          | Null | Key | Default | Extra          |
+---------------+---------------+------+-----+---------+----------------+
| id            | int(11)       | NO   | PRI | NULL    | auto_increment |
| numeroArticle | varchar(25)   | NO   | UNI | NULL    |                |
| designation   | varchar(250)  | NO   |     | NULL    |                |
| prixUnitaire  | decimal(12,2) | NO   |     | NULL    |                |
+---------------+---------------+------+-----+---------+----------------+
4 rows in set (0.09 sec) */

-- Afficher la requete de la création de la table article
/* show create table article;
+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table   | Create Table                                                                                                                                                                                                                                                                                                          |
+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| article | CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numeroArticle` varchar(25) NOT NULL,
  `designation` varchar(250) NOT NULL,
  `prixUnitaire` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numeroArticle` (`numeroArticle`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 |
+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec) */

-- Créer la table client
create table client(id int auto_increment primary key,
					numeroClient varchar(25) not null unique,
					nomClient varchar(250) not null,
					adresseClient varchar(250));
-- inserer des données
insert into client values (null, 'CLT0014', 'Claude', 'Clisson'),
							(null, 'CLT0015', 'Roger', 'Rennes'),
							(null, 'CLT0032', 'Marie', 'Marseille');
							
-- Créer la table commande
create table commande(id int auto_increment primary key,
						numeroCommande varchar(25) not null unique,
						dateCommande timestamp not null,
						client_id int not null,
						foreign key(client_id) references client(id));
-- insérer des données dans la table commande
insert into commande (dateCommande, numeroCommande, client_id) values ('2017/01/12', 'CDE012487',1),
																		('2017/02/21','CDE011258',2),
																		('2017/03/25','CDE012478',3),
																		('2017/04/30','CDE021487',2);
																		
-- afficher
select * from commande;
/* +----+----------------+---------------------+-----------+
| id | numeroCommande | dateCommande        | client_id |
+----+----------------+---------------------+-----------+
|  1 | CDE012487      | 2017-01-12 00:00:00 |         1 |
|  2 | CDE011258      | 2017-02-21 00:00:00 |         2 |
|  3 | CDE012478      | 2017-03-25 00:00:00 |         3 |
|  4 | CDE021487      | 2017-04-30 00:00:00 |         2 |
+----+----------------+---------------------+-----------+
4 rows in set (0.00 sec) */

-- créer la table ligneCommande
create table ligneCommande (id int auto_increment primary key, commande_id int not null, article_id int not null, quantite decimal(10,2) default 1,
								foreign key(commande_id) references commande(id),
								foreign key(article_id) references article(id));

-- insertion
insert into ligneCommande (commande_id, article_id, quantite) values (1, 5, 128),
																		(1, 4, 18),
																		(1, 3, 148),
																		
																		(2, 1, 145),
																		(2, 2, 140),
																		
																		(3, 1, 45),
																		(3, 2, 75),
																		
																		(4, 1, 45);
																		
-- Test de la contrainte d'intégrité sur la colonne article_id
insert into ligneCommande (commande_id, article_id, quantite) values (4, 100, 45);
/* ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails 
(`poei2018`.`lignecommande`, CONSTRAINT `lignecommande_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`))	 */		

select numeroArticle, designation, prixUnitaire, quantite from article, ligneCommande where ligneCommande.article_id = article_id;

-- correction TP : création d'une view
create view v_ligneCommande as
select a.numeroArticle as code, a.designation, a.prixUnitaire as pu,
l.quantite as qte, l.quantite * a.prixUnitaire as montant
from article as a, ligneCommande as l
where l.article_id = a.id;	
/* 
+-------+-----------------------+-------+--------+-----------+
| code  | designation           | pu    | qte    | montant   |
+-------+-----------------------+-------+--------+-----------+
| XX032 | Riz Basmati 25kg      | 25.20 | 128.00 | 3225.6000 |
| AM012 | Huile moteur 40w10 2L |  5.20 |  18.00 |   93.6000 |
| EL020 | Multiprise électrique |  7.20 | 148.00 | 1065.6000 
| BB001 | Bière Castel 350ml    |  3.50 | 145.00 |  507.5000 |
| BJ001 | Jus d'ananas 1.5L     |  2.50 | 140.00 |  350.0000 |
| BB001 | Bière Castel 350ml    |  3.50 |  45.00 |  157.5000 |
| BJ001 | Jus d'ananas 1.5L     |  2.50 |  75.00 |  187.5000 |
| BB001 | Bière Castel 350ml    |  3.50 |  45.00 |  157.5000 |
+-------+-----------------------+-------+--------+-----------+
8 rows in set (0.00 sec) */

-- View 2
create or replace view v_totalCommande as
select c.numeroCommande as 'N°Commande', c.dateCommande as 'date', 
round(sum(l.quantite*a.prixUnitaire),2) as Total
from commande as c, article as a, ligneCommande as l
where c.id = l.commande_id and l.article_id = a.id
group by c.numeroCommande
order by c.dateCommande;

-- Création d'une table produit à partir de la table article
create table produit like article;
insert into produit select * from article;

--- delete
delete from produit where id = 2 or id = 3;
-- ou
delete from produit where id in (2,3);

-- truncate
truncate table produit;

-- tp2

-- correction avec if
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		sum(if (month(c.dateCommande) = 1, l.quantite, 0)) as Janvier,
		sum(if (month(c.dateCommande) = 2, l.quantite, 0)) as Février,
		sum(if (month(c.dateCommande) = 3, l.quantite, 0)) as Mars,
		sum(if (month(c.dateCommande) not in (1,2,3), l.quantite, 0)) as Autres
from article a, ligneCommande l, commande c
where l.article_id = a.id and c.id = l.commande_id
group by Annee, Code order by Annee, Code;

-- avec case
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		sum(case when month(c.dateCommande) = 1 then l.quantite else 0 end) as Janvier,
		sum(case when month(c.dateCommande) = 2 then l.quantite else 0 end) as Février,
		sum(case when month(c.dateCommande) = 3 then l.quantite else 0 end) as Mars,
		sum(case when month(c.dateCommande) > 3 then l.quantite else 0 end) as Autres
from article a, ligneCommande l, commande c
where l.article_id = a.id and c.id = l.commande_id
group by Code order by Annee, Code;
	
-- avec Union all (execution plus rapide)
create or replace view v_stat_intermediaire as
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		l.quantite as Janvier, 0 as Février, 0 as Mars, 0 as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) = 1
union all
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		0 as Janvier, l.quantite as Février, 0 as Mars, 0 as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) = 2
union all
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		0 as Janvier, 0 as Février, l.quantite as Mars, 0 as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) = 3
union all
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		0 as Janvier, 0 as Février, 0 as Mars, l.quantite as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) > 3;

---
create or replace view v_stat_finale as
select Annee, Code, Article, PU, sum(Janvier) as Janvier,
									sum(Février) as Février,
									sum(Mars) as Mars,
									sum(Autres) as Autres
from v_stat_intermediaire
group by Annee, Code;


--- Sous requete

select Annee, Code, Article, PU, sum(Janvier) as Janvier,
									sum(Février) as Février,
									sum(Mars) as Mars,
									sum(Autres) as Autres
from (select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		l.quantite as Janvier, 0 as Février, 0 as Mars, 0 as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) = 1
union all
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		0 as Janvier, l.quantite as Février, 0 as Mars, 0 as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) = 2
union all
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		0 as Janvier, 0 as Février, l.quantite as Mars, 0 as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) = 3
union all
select year(c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		0 as Janvier, 0 as Février, 0 as Mars, l.quantite as Autres
from article a, ligneCommande l, commande c
where (l.article_id = a.id and c.id = l.commande_id) and month(c.dateCommande) > 3 ) as v
group by Annee, Code;

--- TP3

-- View 1
create or replace view v_ca_client as
select year(cde.datecommande) as Annee, clt.numeroClient as 'N° Client',
clt.nomClient Client, clt.adresseClient as Adresse, round(sum(lcde.quantite*art.prixUnitaire),2) as CA
from commande cde, lignecommande lcde, article art, client clt
where lcde.commande_id = cde.id and lcde.article_id = art.id and cde.client_id = clt.id
group by annee, numeroClient order by annee, numeroClient;

-- View 2 
create or replace view v_ca_total as
select year(cde.datecommande) as annee, round(sum(lcde.quantite*art.prixUnitaire),2) as ca
from commande cde, lignecommande lcde, article art
where lcde.commande_id = cde.id and lcde.article_id = art.id
group by annee order by annee;

-- view finale
create or replace view v_ca_finale as
select v1.*, v2.ca as total, concat(round((v1.ca/v2.ca) *100,2), " %") as "%"
from v_ca_client v1, v_ca_total v2
where v1.annee = v2.annee;

-- jointure
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

-- cross join
select * from a cross join b;
-- ou
select * from a,b;

-- +------+------+------+--------+
-- | id   | nom  | id   | valeur |
-- +------+------+------+--------+
-- |    1 | a    |    1 | x      |
-- |    2 | b    |    1 | x      |
-- |    3 | c    |    1 | x      |
-- |    4 | d    |    1 | x      |
-- |    1 | a    |    3 | y      |
-- |    2 | b    |    3 | y      |
-- |    3 | c    |    3 | y      |
-- |    4 | d    |    3 | y      |
-- |    1 | a    |    5 | z      |
-- |    2 | b    |    5 | z      |
-- |    3 | c    |    5 | z      |
-- |    4 | d    |    5 | z      |
-- |    1 | a    |    7 | w      |
-- |    2 | b    |    7 | w      |
-- |    3 | c    |    7 | w      |
-- |    4 | d    |    7 | w      |
-- +------+------+------+--------+
-- 16 rows in set (0.00 sec)
-- -- 

-- inner join
select * from a inner join b on a.id = b.id;
-- ou
select * from a,b where a.id = b.id;
-- +------+------+------+--------+
-- | id   | nom  | id   | valeur |
-- +------+------+------+--------+
-- |    1 | a    |    1 | x      |
-- |    3 | c    |    3 | y      |
-- +------+------+------+--------+
-- 2 rows in set (0.00 sec)

-- left join
select * from a left join b on a.id = b.id;
-- +------+------+------+--------+
-- | id   | nom  | id   | valeur |
-- +------+------+------+--------+
-- |    1 | a    |    1 | x      |
-- |    3 | c    |    3 | y      |
-- |    2 | b    | NULL | NULL   |
-- |    4 | d    | NULL | NULL   |
-- +------+------+------+--------+
-- 4 rows in set (0.00 sec)

-- right join
select * from a right join b on a.id = b.id;
-- +------+------+------+--------+
-- | id   | nom  | id   | valeur |
-- +------+------+------+--------+
-- |    1 | a    |    1 | x      |
-- |    3 | c    |    3 | y      |
-- | NULL | NULL |    5 | z      |
-- | NULL | NULL |    7 | w      |
-- +------+------+------+--------+
-- 4 rows in set (0.00 sec)

-- coalesce
select a.*, coalesce(b.id,0), coalesce(b.valeur,'Aucune valeur') from a left join b on a.id = b.id;
-- +------+------+------------------+------------------------------------+
-- | id   | nom  | coalesce(b.id,0) | coalesce(b.valeur,'Aucune valeur') |
-- +------+------+------------------+------------------------------------+
-- |    1 | a    |                1 | x                                  |
-- |    3 | c    |                3 | y                                  |
-- |    2 | b    |                0 | Aucune valeur                      |
-- |    4 | d    |                0 | Aucune valeur                      |
-- +------+------+------------------+------------------------------------+
-- 4 rows in set (0.00 sec)

-- full join (equivaut à left union right en mysql)

-- 1ère méthode
select a.*, coalesce(b.id,0) as 'id', coalesce(b.valeur,'Aucune valeur') as 'valeur' from a left join b on a.id = b.id
union
select coalesce(a.id,0), coalesce(a.nom,'Aucune valeur'), b.* from a right join b on a.id = b.id;
-- +------+---------------+------------------+------------------------------------+
-- | id   | nom           | coalesce(b.id,0) | coalesce(b.valeur,'Aucune valeur') |
-- +------+---------------+------------------+------------------------------------+
-- |    1 | a             |                1 | x                                  |
-- |    3 | c             |                3 | y                                  |
-- |    2 | b             |                0 | Aucune valeur                      |
-- |    4 | d             |                0 | Aucune valeur                      |
-- |    0 | Aucune valeur |                5 | z                                  |
-- |    0 | Aucune valeur |                7 | w                                  |
-- +------+---------------+------------------+------------------------------------+
-- 6 rows in set (0.00 sec)

-- 2 ème méthode
create or replace view v_id as 
select id from a
union
select id from b;
--
select *
from v_id v left join a on v.id = a.id
left join b on v.id = b.id;

-- TP 4
/*
1) Créez respectivement avec like les tables Fournisseur, Appro, LigneAppro similaires aux tables
Client, Commande, lignecommande
2) Ajustez les noms des champs aux noms des tables ainsi que les contraintes d'intégrité aux clés étrangères
3) Rajoutez un champ prixRevient à la table Article. Mettez à jour ce champ à 50% du prixUnitaire
4) Insérez des données dans les nouvelles tables que vous venez de créer
5) Créez une view de nom v_stock correspondant au tableau suivant :
code	article		PR		Appro	Vente		Stock
-		-			-		-		-			-
-		-			-		-		-			-
-		-			-		-		-			-
-		-			-		-		-			-
Appro = quantité approvisionnée
Vente = quantité vendue
Stock = Appro-vente
*/

--1
create table fournisseur like client;
create table appro like commande;
create table ligneAppro like ligneCommande;

--2
-- ex : ALTER TABLE Client CHANGE COLUMN nom nomClient
-- varchar(100);
alter table fournisseur change column numeroClient numeroFournisseur varchar(25);
alter table fournisseur change column nomClient nomFournisseur varchar(250);
alter table fournisseur change column adresseClient adresseFournisseur varchar(250);
alter table fournisseur modify numeroFournisseur varchar(25) not null;
alter table fournisseur modify nomFournisseur varchar(250) not null;

alter table appro change column numeroCommande numeroAppro varchar(25);
alter table appro modify numeroAppro varchar(25) not null;
alter table appro change column dateCommande dateAppro timestamp;
alter table appro change column client_id fournisseur_id int not null;
alter table appro add constraint fk_fournisseur foreign key (fournisseur_id) references fournisseur(id);

alter table ligneAppro change column commande_id appro_id int not null;
alter table ligneAppro add constraint fk_commande foreign key (appro_id) references appro(id);
alter table ligneAppro add foreign key (article_id) references article(id);
alter table ligneAppro alter quantite set default 1;

--3
alter table article add prixRevient decimal(10,2);
alter table article modify prixRevient decimal(10,2) not null;
update article set prixRevient=prixUnitaire/2;

--4
insert into fournisseur values
							(null, 'FCLI001', 'Charles', 'Clisson'),
							(null, 'FREN014', 'Renée', 'Rennes'),
							(null, 'FMAR740', 'Maurice', 'Marseille'),
							(null, 'FLOR007', 'Laure', 'Lorient');

insert into appro values	
							(null, 'APR017888', '2016/01/25', 1),
							(null, 'APR018002', '2016/08/17', 2),
							(null, 'APR019003', '2017/03/28', 3),
							(null, 'APR021007', '2017/12/30', 4),
							(null, 'APR022009', '2018/01/01', 4);

insert into ligneAppro(appro_id, article_id, quantite) values
							(1, 3, 1000),
							(1, 4, 20),
							(1, 5, 50000),
							(2, 2, 300),
							(3, 1, 50000),
							(3, 4, 500),
							(4, 4, 1200),
							(4, 5, 35000),
							(5, 3, 700),
							(5, 5, 124000);

-- 5
-- code	article		PR		Appro	Vente		Stock
-- -		-			-		-		-			-
-- -		-			-		-		-			-
-- -		-			-		-		-			-
-- -		-			-		-		-			-
-- Appro = quantité approvisionnée
-- Vente = quantité vendue
-- Stock = Appro-vente

-- à finir
create or replace view v_stock as
select art.numeroArticle as 'Code', art.designation as 'Article', lapp.prixRevient as 'PR', lapp.quantite as 'Appro',
			lcde.quantite as 'Vente', (lapp.quantite - lcde.quantite) as 'Stock'

from article art, ligneAppro lapp, ligneCommande lcde

where  ;

-- corrigé
create or replace view v_stock_intermediaire as
select l.article_id, l.quantite as appro, 0 vente from ligneAppro l
union all
select l.article_id, 0 as appro, l.quantite vente from lignecommande l;
-- view stock finale
create or replace view v_stock_finale as
select a.numeroArticle as code, a.designation as article, a.prixRevient as pr,
		sum(v.appro) as appro, sum(v.vente) as vente, sum(v.appro - v.vente) as Stock
from article a inner join v_stock_intermediaire v on a.id = v.article_id
group by numeroArticle;
-- +-------+-----------------------+-------+-----------+--------+-----------+
-- | code  | article               | pr    | appro     | vente  | Stock     |
-- +-------+-----------------------+-------+-----------+--------+-----------+
-- | AM012 | Huile moteur 40w10 2L |  2.60 |   1720.00 |  18.00 |   1702.00 |
-- | BB001 | Bière Castel 350ml    |  1.75 |  50000.00 | 235.00 |  49765.00 |
-- | BJ001 | Jus d'ananas 1.5L     |  1.25 |    300.00 | 215.00 |     85.00 |
-- | EL020 | Multiprise électrique |  3.60 |   1700.00 | 148.00 |   1552.00 |
-- | XX032 | Riz Basmati 25kg      | 12.60 | 209000.00 | 128.00 | 208872.00 |
-- +-------+-----------------------+-------+-----------+--------+-----------+
-- 5 rows in set (0.00 sec)

-- ajout d'un article non utilisé
insert into article values (null,'CS0015','Cigarette Gauloise',8.20,4.10);

-- view stock finale avec un "left join" pour ajouter les articles sans lignecommande ni ligneappro
create or replace view v_stock_finale as
select a.numeroArticle as code, a.designation as article, a.prixRevient as pr,
		sum(v.appro) as appro, sum(v.vente) as vente, sum(v.appro - v.vente) as Stock
from article a left join v_stock_intermediaire v on a.id = v.article_id
group by numeroArticle;


---- Sauvegarde des données
mysqldump -u root poei2018 > c:\test\poei2018\Sauvegarde_poei2018.sql
-- restaurer le fichier dump dans une bdd copie_2018 préalablement créée
mysql -u root copie_poei2018 < c:\test\poei2018\sauvegarde_poei2018.sql
-- sauvegarde de la bdd poei2018 à vide
mysqldump -u root -d poei2018 > c:\test\poei2018\sauvegarde_poei2018.sql
-- restauration
mysql -u root poei2018_vide < c:\test\poei2018\sauvegarde_poei2018.sql



-- Creation d'un utilisateur imie
insert into user(user,host, password) values
										('imie','localhost',password('1234'));
flush privileges;
-- ou
create user imie@localhost identified by '1234';
-- créer l'utilisateur paul
create user paul@localhost identified by '1234';
-- donner le droit d'afficher numeroArticle et designation à paul
grant select(numeroArticle,designation) on poei2018.article to paul@localhost;
-- donner le droit de supprimer et modifier la table client à paul
grant alter, drop on poei2018.client to paul@localhost;
-- créer un utilisateur claude qui a le droit d'afficher la table commande
grant select on poei2018.commande to claude@localhost identified by '1234';
-- changer le mot de passe de paul en '4321'
set password for paul@localhost=password('4321');
-- enlever le droit alter client à claudia
revoke select on poei2018.commande from claude@localhost;
-- afficher les droits de paul
show grants for paul@localhost;

-- tp 5

-- Créer utilisateurs avec leurs droits suivant le tableau suivant :
/*
GROUPE		UTILISATEUR 	Article		Client		Commande		ligneCommande

DIRECTION	Rene			tout droit	tout droit 	select			select
			Paul			   *			*			*				*
CAISSE		Claude			select		select		tout droit		tout droit
			Marie				*			*			*				*
DEPOT		Robert			update		aucun		aucun			aucun
							(prixRevient)
*/

grant all privileges on poei2018.article to rene@localhost identified by '1234';
grant all privileges on poei2018.client to rene@localhost;
grant all privileges on poei2018.article to paul@localhost identified by '1234';
grant all privileges on poei2018.client to rene@localhost;
grant select on poei2018.commande to rene@localhost, paul@localhost;
grant select on poei2018.ligneCommande to rene@localhost, paul@localhost;

grant select on poei2018.article to claude@localhost identified by '1234', marie@localhost identified by '1234';
grant select on poei2018.client to claude@localhost, marie@localhost;
grant all privileges on poei2018.commande to claude@localhost, marie@localhost;
grant all privileges on poei2018.ligneCommande to claude@localhost, marie@localhost;

grant update(prixRevient) on poei2018.article to robert@localhost identified by '1234';
grant select(id) on poei2018.article to robert@localhost;

create role DIRECTION;
create role CAISSE;
create role DEPOT;

-- correction
grant all on poei2018.article to DIRECTION;
grant all on poei2018.client to DIRECTION;
grant select on poei2018.commande to DIRECTION;
grant select on poei.ligneCommande to DIRECTION;

grant select on poei2018.article to CAISSE;
grant select on poei2018.client to CAISSE;
grant all on poei2018.commande to CAISSE;
grant all on poei2018.ligneCommande to CAISSE;

grant update(prixRevient) on poei2018.article to DEPOT;

grant DIRECTION to rene@localhost identified by '1234', paul@localhost identified by '1234';
grant CAISSE to claude@localhost identified by '1234', marie@localhost identified by '1234';
grant DEPOT to robert@localhost identified by '1234';
grant DIRECTION to robert@localhost;
revoke DIRECTION from robert@localhost;

-- se connecter en tant que robert au serveur
mysql -u robert -p poei2018;
-- activer le groupe direction
set role DIRECTION;
-- activer le groupe depot
set role DEPOT;
-- desactiver tout groupe
set role none;
-- detacher robert au groupe depot
revoke depot from robert@localhost;