-- table space (cf pdf)
create tablespace data_poei2018 location 'C:/test/poei2018/bdd';
-- création d'une bdd imie_poei2018 dans la tablespace data_poei2018
create database imie_poei2018 tablespace data_poei2018;

-- systeme regle
create table article_log(article_id int, numeroArticle varchar(25), 
    designation varchar(250), ancienPrix decimal(10,2), nouveauPrix decimal(10,2),
    operateur varchar(100), dateOperation timestamp, evenement varchar(100));

create or replace rule modif_pu as on update to article
where old.prixUnitaire <> new.prixUnitaire
do insert into article_log values
(old.id, old.numeroArticle, old.designation, old.prixUnitaire, new.prixUnitaire, current_user, now(), 'update');

-- tester le systeme
update article set prixUnitaire=1.20 where id=2;
 article_id | numeroarticle |  designation   | ancienprix | nouveauprix | operateur |       dateoperation        | evenement
------------+---------------+----------------+------------+-------------+-----------+----------------------------+-----------
          2 | ART0000501    | Crepe bretonne |       0.40 |        1.20 | postgres  | 2018-07-26 10:06:39.471328 | update
(1 ligne)

create user jean superuser password '1234';
-- se connecter à la base de données poei2018 en tant que jean
\c poei2018 jean


create or replace rule article_sup as on delete to article
do insert into article_log values
(old.id, old.numeroArticle, old.designation, old.prixUnitaire, null, current_user, now(), 'delete');


insert into article(designation, prixUnitaire, prixRevient) values
    ('Stylo', 1.5, 0.5),
    ('Cartable', 60.50,20);

delete from article where id=5;
 article_id | numeroarticle |  designation   | ancienprix | nouveauprix | operateur |       dateoperation        | evenement
------------+---------------+----------------+------------+-------------+-----------+----------------------------+-----------
          2 | ART0000501    | Crepe bretonne |       0.40 |        1.20 | postgres  | 2018-07-26 10:06:39.471328 | update
          5 | ART0000504    | Stylo          |       1.50 |             | jean      | 2018-07-26 10:31:21.29938  | delete
(2 lignes)

---
create sequence numero_client_seq start 500;
create table client() inherits(tiers);
alter table client alter numeroTiers set default numeroter('CLT', 'numero_client_seq');
alter table client add check(left(numeroTiers,3)='CLT');

insert into client(nomTiers, adresseTiers) values
('Marcel','Marseille'),
('Nancie','Nancy');
 id | numerotiers | nomtiers | adressetiers
----+-------------+----------+--------------
  8 | CLT0000500  | Marcel   | Marseille
  9 | CLT0000501  | Nancie   | Nancy
(2 lignes)

alter table client add unique(numeroTiers);

------- afficher les données saisies réellement dans la table tiers
select * from only tiers;
-- detacher client a la table tiers
alter table client no inherit tiers;
----
insert into client (nomTiers, adresseTiers) values
    ('John','Johannesbourg');

-- rattache client à la table tiers
alter table client inherit tiers;

insert into client (id,nomTiers,adressetiers) 
    (select id,nomTiers,adressetiers from only tiers);

------- creation de la table vente qui hérite de la table commande *
create sequence numero_vente_seq start 2000;
create table vente(check(typeCommande='VTE'),unique(numeroCommande)) inherits(commande);
alter table vente alter typeCommande set default 'VTE';
alter table vente alter numeroCommande set default numeroter('VTE','numero_vente_seq');

-- enlever la contrainte d'intégrité check sur typecommande
alter table commande drop constraint commande_typeCommande_check;
-- basculer le contenu de la table mere commande vers la table fille vente
insert into vente(id, dateCommande, tiers_id)
    (select id,dateCommande,tiers_id from only commande);



-- ajouter primary key dans vente
alter table vente add primary key(id);
alter table client add primary key(id);
-- foreign key tiers_id
alter table vente add foreign key(tiers_id) references client(id);
----
create table ligneVente(primary key(id), foreign key(commande_id) references vente(id),
foreign key(article_id) references article(id)) inherits(ligneCommande);
-- ou
create table ligneVente() inherits(ligneCommande);
alter table ligneVente add primary key(id);
alter table ligneVente add foreign key(commande_id) references vente(id);
alter table ligneVente add foreign key(article_id) references article(id);

-- basculer le contenu de la table mere lignecommande vers la table fille lignevente
insert into ligneVente (id, commande_id, article_id, quantite)
    (select id, commande_id, article_id, quantite from only ligneCommande);

-- vider les tables meres
delete from only ligneCommande;
delete from only commande;
delete from only tiers;


---- TP ---


-- table fournisseur
create sequence numero_fournisseur_seq start 200;
create table fournisseur() inherits(tiers);

alter table fournisseur alter numeroTiers set default numeroter('FRN', 'numero_fournisseur_seq');
alter table fournisseur add check(left(numeroTiers,3)='FRN');
alter table fournisseur add primary key(id);
alter table fournisseur add unique(numeroTiers);

insert into fournisseur (nomTiers, adresseTiers) values
    ('Alain','Alençon'),
    ('Briec','Briançon'),
    ('Marine','Marignan'),
    ('Valentin','Valence');

    -- table appro

create sequence numero_appro_seq start 100;
create table appro(
    check(typeCommande='APR'),
    unique(numeroCommande)
    ) 
inherits(commande);
alter table appro alter typeCommande set default 'APR';
alter table appro alter numeroCommande set default numeroter('APR','numero_appro_seq');
alter table appro add primary key(id);

alter table appro drop constraint appro_tiers_id_fkey;
alter table appro add foreign key(tiers_id) references fournisseur(id);

insert into appro (typeCommande, dateCommande, tiers_id) values
    ('APR','2017-01-20',15),
    ('APR','2017-02-10',16),
    ('APR','2017-03-10',17),
    ('APR','2017-04-10',18);

    -- table ligneAppro

create table ligneAppro(
    primary key(id), 
    foreign key(commande_id) references appro(id),
    foreign key(article_id) references article(id)
    ) 
inherits(ligneCommande);

insert into ligneAppro (commande_id, article_id, quantite) values
    (18, 1, 2000),
    (18, 3, 500),
    (18, 2, 5000),
    (19, 6, 2000),
    (19, 4, 400),
    (20, 3, 5000),
    (21, 6, 300);

-- Tableau : Code / Article / PR / Appro / Vente / Stock / Valeur (= stock*PR)

create or replace view v_stock_intermediaire as
select l.article_id, l.quantite as appro, 0 vente from ligneAppro l
union all
select l.article_id, 0 as appro, l.quantite vente from lignecommande l;

create or replace view v_stock_finale as
select a.numeroArticle as Code, a.designation as Article, a.prixRevient as PR,
		sum(v.appro) as Appro, 
        sum(v.vente) as Vente, 
        sum(v.appro - v.vente) as Stock,
        sum(Stock * PR) as Valeur
from article a inner join v_stock_intermediaire v on a.id = v.article_id
group by numeroArticle, designation, prixRevient;


---- Correction TP

-- Tableau

-- 1) Méthode WITH et left join

with
    v_appro(article_id, quantite) as (
        select article_id, sum(quantite) from ligneAppro group by article_id
    ),
    v_vente(article_id, quantite) as (
        select article_id, sum(quantite) from ligneVente group by article_id
    )

    select a.numeroarticle as Code, a.designation as Article, a.prixRevient as PR,
            sum(v1.quantite) as Appro, sum(v2.quantite) as Vente, sum(coalesce(v1.quantite,0) - coalesce(v2.quantite,0)) as Stock,
            sum((coalesce(v1.quantite,0)-coalesce(v2.quantite,0)) * a.prixRevient) as Valeur
    from article a left join v_appro v1 on a.id = v1.article_id
                    left join v_vente v2 on a.id = v2.article_id
    group by Code, Article, PR order by Code;

       code    |    article     |  pr   |  appro   |  vente  |  stock   |   valeur
------------+----------------+-------+----------+---------+----------+------------
 ART0000502 | Farine 1kg     |  0.25 | 16500.00 |  408.00 | 16092.00 |  4023.0000
 ART0000500 | Bière Castel   |  2.25 |  6000.00 | 2056.00 |  3944.00 |  8874.0000
 ART0000503 | Confiture 250g |  0.75 |   400.00 |         |   400.00 |   300.0000
 ART0000501 | Crepe bretonne |  0.20 | 10000.00 |  904.00 |  9096.00 |  1819.2000
 ART0000505 | Cartable       | 20.00 |  2300.00 |         |  2300.00 | 46000.0000

 -- 2) 2ème méthode avec with et Union all

 with
    v_appro_vente(article_id, appro, vente) as (
        select article_id, quantite, 0
        from ligneappro l
        union all
        select article_id, 0, quantite
        from ligneVente l
    )

    select a.numeroarticle as Code, a.designation as Article, a.prixRevient as PR,
        sum(appro) as Appro, sum(vente) as Vente, sum(appro-vente) as Stock,
        sum(appro-vente)*prixRevient as Valeur

        from article a left join v_appro_vente v on v.article_id = a.id
        group by Code, Article, PR order by Code;

-- 3) Méthode Case / when

with
    v(article_id, appro, vente) as (
        select article_id,
            sum(case when c.typeCommande = 'APR' then l.quantite else 0 end),
            sum(case when c.typecommande = 'VTE' then l.quantite else 0 end)
        from commande as c, ligneCommande as l where l.commande_id = c.id group by article_id
    )

    select a.numeroarticle as Code, a.designation as Article, a.prixRevient as PR,
        appro as Appro, vente as Vente, appro-vente as stock,
        (appro-vente)* prixRevient as valeur
    from article a left join v on v.article_id = a.id
    order by code;


    