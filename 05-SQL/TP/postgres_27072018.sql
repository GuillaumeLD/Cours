
    -- TP : tableau Annee / Code / Article / Moyenne (de l'année) / CA

create or replace view v_ca_moyenne as
    with
        v1 (annee, code, article, ca) as
        (select extract(year from v.dateCommande) as Annee, a.numeroArticle as Code, a.designation,
            sum(l.quantite*a.prixUnitaire)
        
        from vente v, article a, ligneVente l
        where l.commande_id = v.id and l.article_id = a.id
        group by Annee, Code, designation
        ),

        v2 (annee, moyenne) as 
        (select extract(year from v.dateCommande) as Annee, avg(l.quantite*a.prixUnitaire)
        from vente v, article a, ligneVente l
        where l.commande_id = v.id and l.article_id = a.id
        group by Annee
        )

        select v1.annee, v1.code, v1.article, v2.moyenne, v1.ca
        from v1, v2 
        where v1.annee = v2.annee
        order by v1.annee, v1.code;

-- Schema

-- afficher le schema
\dn 
-- creation d'un schema vente
create schema vente;
-- creation d'une table dans le schema vente
create table vente.produit(id serial primary key, designation varchar(250));
-- se deplacer veers le schema vente
set search_path to vente;
-- changer le schema d'une table
alter table produit set schema public;
-- afficher le nom du schema en cours
show search_path;
-- donner un droit d'utilisation d'un schema
grant usage on schema vente to paul;
-- donner le droit d'utilisation de toutes les sequences du schema vente
grant usage on all sequences in schema vente to paul;
-- donner le droit d'utilisation de toutes les fonctions du schema vente
grant execute on all functions in schema vente to paul;


-- sauvegarde de données

pg_dump -U postgres poei2018 > c:\test\poei2018\sauvegarde_postgres_poei2018.sql
-- avant de restaurer il faut créer une bdd
createdb -U postgres copie_poei2018
-- restaurer le fichier dump dans la bdd copie_poei2018
psql -U postgres copie_poei2018 < c:\test\poei2018\sauvegarde_postgres_poei2018.sql
-- se connecter directement à la bdd copie_poei2018
psql -U postgres copie_poei2018

-- 
create table vente.commande  as select * from public.commande;
create table vente.ligneCommande as select * from public.ligneCommande where 2 > 3;


-- TP 

--1
createdb -U postgres poei2018tp
pg_dump -U postgres -s poei2018 > c:\test\poei2018\sauvegarde_structure_poei2018.sql
psql -U postgres poei2018tp < c:\test\poei2018\sauvegarde_structure_poei2018.sql

\c poei2018tp

create schema appro;
create schema vente;

create table appro.commande as select * from public.commande;
create table appro.ligneCommande as select * from public.ligneCommande;
create table appro.tiers as select * from public.tiers;

create table vente.commande as select * from public.commande;
create table vente.ligneCommande as select * from public.ligneCommande;
create table vente.tiers as select * from public.tiers;

drop table public.appro cascade;
drop table public.article_log cascade;
drop table public.client cascade;
drop table public.commande cascade;
drop table public.fournisseur cascade;
drop table public.ligneAppro cascade;
drop table public.ligneCommande cascade;
drop table public.ligneVente cascade;
drop table public.produit cascade;
drop table public.tiers cascade;
drop table public.vente cascade;

-- poei2018tp=# set search_path to public;
-- SET
-- poei2018tp=# \d
--                     Liste des relations
--  SchÚma |          Nom           |   Type   | PropriÚtaire
-- --------+------------------------+----------+--------------
--  public | article                | table    | postgres
--  public | article_id_seq         | sÚquence | postgres
--  public | numero_appro_seq       | sÚquence | jean
--  public | numero_article_seq     | sÚquence | postgres
--  public | numero_client_seq      | sÚquence | jean
--  public | numero_commande_seq    | sÚquence | postgres
--  public | numero_fournisseur_seq | sÚquence | jean
--  public | numero_tiers_seq       | sÚquence | postgres
--  public | numero_vente_seq       | sÚquence | jean
-- (9 lignes)

-- poei2018tp=# set search_path to appro;
-- SET
-- poei2018tp=# \d
--               Liste des relations
--  SchÚma |      Nom      | Type  | PropriÚtaire
-- --------+---------------+-------+--------------
--  appro  | commande      | table | postgres
--  appro  | lignecommande | table | postgres
--  appro  | tiers         | table | postgres
-- (3 lignes)

-- poei2018tp=# set search_path to vente;
-- SET
-- poei2018tp=# \d
--               Liste des relations
--  SchÚma |      Nom      | Type  | PropriÚtaire
-- --------+---------------+-------+--------------
--  vente  | commande      | table | postgres
--  vente  | lignecommande | table | postgres
--  vente  | tiers         | table | postgres
-- (3 lignes)


-- Réinsertion de données

insert into  public.article(designation,prixUnitaire,prixRevient) values
         ('Bière Castel 350ml',3.60,1.80),
        ('Jus d''ananas 1.5L',2.40,1.20),
        ('Multiprise électrique',8.20,4.10),
        ('Huile moteur 40w10 2L',6.20,3.10),
        ('Riz Basmati 25kg',24.20,12.10);

--2

create role depot;
create role comptoire;

create user Dupont;
create user Claude;
create user Roger;
create user Norbert;
create user Marie;
create user Claudette;
create user Rosette;
create user Rogette;

grant depot to Dupont, Claude, Roger, Norbert;
grant comptoire to Marie, Claudette, Rosette, Rogette;

-- poei2018tp=# \du
--                                                Liste des r¶les
--  Nom du r¶le |                                    Attributs                                    |  Membre de
-- -------------+---------------------------------------------------------------------------------+-------------
--  claude      |                                                                                 | {depot}
--  claudette   |                                                                                 | {comptoire}
--  comptoire   | Ne peut pas se connecter                                                        | {}
--  depot       | Ne peut pas se connecter                                                        | {}
--  direction   | Ne peut pas se connecter                                                        | {}
--  dupont      |                                                                                 | {depot}
--  jean        | Superutilisateur                                                                | {}
--  marie       |                                                                                 | {comptoire}
--  norbert     |                                                                                 | {depot}
--  poeirennes  | CrÚer un r¶le                                                                   | {}
--  postgres    | Superutilisateur, CrÚer un r¶le, CrÚer une base, RÚplication, Contournement RLS | {}
--  roger       |                                                                                 | {depot}
--  rogette     |                                                                                 | {comptoire}
--  rosette     |                                                                                 | {comptoire}
--  user1       |                                                                                 | {}
--  user2       |                                                                                 | {}
--  user3       | Superutilisateur, CrÚer un r¶le, CrÚer une base                                 | {direction}
--  user4       | CrÚer un r¶le                                                                   | {}


grant select on table public.article, appro.commande, appro.ligneCommande, appro.tiers,
    vente.commande, vente.ligneCommande, vente.tiers to depot, comptoire;

grant insert, update, delete on table appro.commande, appro.lignecommande, appro.tiers,
                                        vente.commande, vente.lignecommande, vente.tiers
                                        to depot, comptoire;

--                  

--   Droits d'accÞs
--  SchÚma |   Nom   | Type  |      Droits d'accÞs       | Droits d'accÞs Ó la colonne | Politiques
-- --------+---------+-------+---------------------------+-----------------------------+------------
--  public | article | table | postgres=arwdDxt/postgres+|                             |
--         |         |       | depot=r/postgres         +|                             |
--         |         |       | comptoire=r/postgres      |                             |
-- (1 ligne)

-- poei2018tp=# \dp appro.ligneCommande
--                                             Droits d'accÞs
--  SchÚma |      Nom      | Type  |      Droits d'accÞs       | Droits d'accÞs Ó la colonne | Politiques
-- --------+---------------+-------+---------------------------+-----------------------------+------------
--  appro  | lignecommande | table | postgres=arwdDxt/postgres+|                             |
--         |               |       | depot=arwd/postgres      +|                             |
--         |               |       | comptoire=arwd/postgres   |                             |
-- (1 ligne)

-- --                          Droits d'accÞs
--  SchÚma |   Nom    | Type  |      Droits d'accÞs       | Droits d'accÞs Ó la colonne | Politiques
-- --------+----------+-------+---------------------------+-----------------------------+------------
--  vente  | commande | table | postgres=arwdDxt/postgres+|                             |
--         |          |       | depot=arwd/postgres      +|                             |
--         |          |       | comptoire=arwd/postgres   |                             |
-- (1 ligne)

-- 3

create or replace view v_stock as
with
    v_appro(article_id, quantite) as (
        select article_id, sum(quantite) from appro.ligneCommande group by article_id
    ),
    v_vente(article_id, quantite) as (
        select article_id, sum(quantite) from vente.ligneCommande group by article_id
    )

    select a.numeroarticle as Code, a.designation as Article, a.prixRevient as PR,
            sum(v1.quantite) as Appro, sum(v2.quantite) as Vente, sum(coalesce(v1.quantite,0) - coalesce(v2.quantite,0)) as Stock
    from public.article a left join v_appro v1 on a.id = v1.article_id
                    left join v_vente v2 on a.id = v2.article_id
    group by Code, Article, PR order by Code;


-- 4