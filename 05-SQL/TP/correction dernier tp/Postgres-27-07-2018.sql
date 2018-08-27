---correction tp
create or replace view v_ca_moyenne as 
with 
	v1(annee,code,article,ca) as 
	(select extract(year from v.datecommande) as annee , a.numeroArticle , a.designation ,
	sum(l.quantite*a.prixUnitaire)
	
	from vente v,article a, ligneVente l 
	where l.commande_id=v.id and l.article_id=a.id group by annee,numeroArticle,designation),
	v2(annee,moyenne) as 
	(select extract(year from v.datecommande) as annee ,avg(l.quantite*a.prixUnitaire)
	from vente v,article a, ligneVente l 
	where l.commande_id=v.id and l.article_id=a.id group by annee )
	
	select v1.annee,v1.code,v1.article,round(v2.moyenne,2),v1.ca
	from v1,v2 where v1.annee=v2.annee and 
	v1.ca > v2.moyenne order by v1.annee,v1.code 
	
;

annee |    code    |    article     | round  |   ca
-------+------------+----------------+--------+---------
  2017 | ART0000001 | Biere castel   | 646.40 | 3080.40
  2017 | ART0000002 | Crepe bretonne | 646.40 | 1084.80
  2017 | ART0000004 | Confiture 250g | 646.40 |  904.00
(3 lignes)

-------schema
---afficher le schema 
\dn
-----creation d'un schema vente
create schema vente;
----creation d'une table dans le schema vente
create table vente.produit(id serial primary key, designation varchar(250));
------se deplacer vers le schema vente 
set search_path to vente
----changer  le schema d'une table 
alter table produit set schema public
----afficher le nom du schema en cours --
show search_path
-----donner un doit d'utilisation d'un schema
grant usage on schema vente to paul

----donner le droit d'utilisation de toutes les sequences du schema vente
grant usage on all sequences in schema vente to paul
----donner le droit d'utilisation de toutes les fonctions du schema vente
grant execute on all functions in schema vente to paul


---sauvegarde de données

pg_dump -U postgres poei2018 > c:\test\poei2018\Sauvegarde_postgres_poei2018.sql
-----avnt de restaurer il faut créer un bdd
createdb -U postgres copie_poei2018
----restaurer le fichier dump dans la bdd copie_poei2018
psql -U postgres copie_poei2018 < c:\test\poei2018\Sauvegarde_postgres_poei2018.sql
---se connecter directement à la bdd copie_poei2018
psql -U postgres copie_poei2018

-------
create table vente.commande as select * from public.commande;
create table vente.ligneCommande as select * from public.lignecommande where 2>3;

-----------------correction tp
createdb -U postgres poei2018tp
createuser -U postgres -P poei2018tp
---restaurer dans la bdd poei2018tp le contenu de la bdd poei2018
psql -U poei2018tp poei2018tp < c:\test\poei2018\poei2018tp.sql
---se connecter avec poei2018tp
psql -U poei2018tp
-------donner le droit de créer un schema à poei2018tp
grant create on database poei2018tp to poei2018tp;
---detacher les tables filles aux tables meres--
alter table vente no inherit commande;
alter table appro no inherit commande;
alter table lignevente no inherit lignecommande;
alter table ligneappro no inherit lignecommande;

alter table client no inherit tiers;
alter table fournisseur no inherit tiers;
----deplacement des tables aux scheémas-----------------------------------------------
alter table vente set schema vente;
alter table lignevente set schema vente;
alter table appro set schema appro;
alter table ligneappro set schema appro;

alter table client set schema vente;
alter table fournisseur set schema appro;
-----renommnder les tables---
alter table vente.vente rename to commande;
alter table vente.lignevente rename to lignecommande;

alter table appro.appro rename to commande;
alter table appro.ligneappro rename to lignecommande;


alter table vente.client rename to tiers;
alter table appro.fournisseur rename to tiers;

---------donner le droit de creer des utilisateur à poei2018tp------------------------
alter user poei2018tp createrole;

----creation de groupe
create role depot;
create role comptoir;
----creation des utilisateurs
create user dupont in role depot password '123';
create user claude in role depot password '123';
create user  roger in role depot password '123';
create user  norbert in role depot password '123' ;

create user marie in role comptoir password '123';
create user rogette in role comptoir password '123';
create user  claudette in role comptoir password '123';
create user  rosette in role comptoir password '123' ;

---------------droit sur les groupe--
grant select on all tables in schema public to depot,comptoir;
grant insert, update,delete on all tables in schema appro to depot;
grant select on all tables in schema vente to depot;


insert into vente.commande (datecommande,typecommande,tiers_id) values ('2018-07-20','VTE',8);


---grante 

grant usage on schema appro to depot;
grant usage on all sequences in schema public to depot;
grant execute on all functions in schema public to depot;



















