-- se connecter au serveur postgres
psql -U postgres
-- creation de la bdd poei2018
create database poei2018;
-- se connecter à la bdd poei2018
\c poei2018
-- creation de la table tiers
create table tiers(id serial primary key, numeroTiers varchar(25) not null unique, nomTiers varchar(250) not null, adresseTiers varchar(250));
-- insertion de données
insert into tiers(numeroTiers, nomTiers, adresseTiers) values
('TIERS00012','Paul','Paris');
-- Création séquence numero_tiers_seq
create sequence numero_tiers_seq start 100;
-- mettre nextval('numero_tiers_seq') comme valeur par défaut à la colonne numeroTiers
alter table tiers alter numeroTiers set default nextval('numero_tiers_seq');
insert into tiers (nomTiers, adresseTiers) values ('Claude', 'Clisson');
|
-- test fonctions concat, ltrim et to_char
select concat('TIERS',ltrim(to_char(21,'000000')));

alter table tiers alter numeroTiers 
set default concat('TIERS', trim(to_char(nextval('numero_tiers_seq'), '000000')));

insert into tiers (nomTiers, adresseTiers) values ('Roger', 'Rennes');

-- création de fonction
create or replace function numeroter(prefixe varchar(10),nom_sequence varchar(100))
returns varchar(100) as
$$
    begin
        return concat(prefixe, trim(to_char(nextval(nom_sequence),'0000000')));
    end
$$language plpgsql;

select numeroter('TIERS','numero_tiers_seq'); -- ???

-- afficher les noms de fonctions existantes
\df
-- editer la fonction numeroter
\ef numeroter
\ef numeroter(prefixe varchar(10), nom_sequence varchar(100)); -- dans la version 10 pas besoin des paramteres

select * from tiers;
update tiers set numerotiers = numeroter('TIERS','numero_tiers_seq');

-- creation de la table commande
create sequence numero_commande_seq start 1000;
create table commande (id serial primary key, numeroCommande varchar(25) not null unique default numeroter('CDE','numero_commande_seq'),
    typeCommande varchar(10) not null, dateCommande timestamp, tiers_id int not null, foreign key (tiers_id) references tiers(id));

-- ajouter une contrainte sur typeCommande
alter table commande add check (typeCommande in ('VTE','APP'));

--- insertion de données dans la table commande
insert into commande (typeCommande, dateCommande, tiers_id) values
    ('VTE','2017-01-25',3),
    ('VTE','2017-02-15',5),
    ('VTE','2017-03-18',6),
    ('VTE','2017-04-12',3);

insert into commande (typeCommande, dateCommande, tiers_id) values
    ('XXX','2017-01-25',3);

-- creation table article
create sequence numero_article_seq start 500;
create table article (id serial primary key, numeroArticle varchar(25) not null unique default numeroter('ART','numero_article_seq'),
    designation varchar(250) not null, prixUnitaire decimal(10,2) not null, prixRevient decimal(10,2) not null);

-- creation table ligneCommande
create table ligneCommande(id serial primary key, commande_id int not null, article_id int not null, quantite decimal(10,2) not null,
    foreign key (commande_id) references commande(id), foreign key (article_id) references article(id));

-- insertion de données
insert into article (designation, prixUnitaire, prixRevient) values
    ('Bière Castel', 5.10, 2.25),
    ('Crepe bretonne', 0.4, 0.2),
    ('Farine 1kg', 0.50, 0.25),
    ('Confiture 250g', 1.50, 0.75);

insert into ligneCommande (commande_id, article_id, quantite) values
    (1,1,1452),
    (1,2,452),
    (1,3,145),
    (2,1,152),
    (2,2,452),
    (2,3,14),
    (3,1,452),
    (4,3,45);

-- tp sur les chiffres d'affaire
create or replace view v_ca_tiers as
select extract(year from c.dateCommande) as annee, t.numeroTiers as numero,
t.nomTiers as Tiers, sum(l.quantite * a.prixUnitaire) as CA
from commande c, tiers t, ligneCommande l, article a
where (c.tiers_id = t.id and l.commande_id = c.id and l.article_id = a.id)
and c.typeCommande = 'VTE'
group by annee, numero, tiers;

create or replace view v_ca_total as
select extract(year from c.dateCommande) as annee, sum(l.quantite * a.prixUnitaire) as CA
from commande c, ligneCommande l, article a
where l.commande_id = c.id and l.article_id = a.id and c.typeCommande = 'VTE'
group by annee;

create or replace view v_ca_finale as
select v1.*, round((v1.CA/v2.CA)*100,2)|| ' %' as Pourcentage
from v_ca_tiers v1, v_ca_total v2
where v1.annee = v2.annee;

--- fenetrage
select v.*, sum(CA) over(partition by annee) as total, round((ca/sum(CA) over(partition by annee))*100,2) as Pourcentage
from v_ca_tiers v;

-- cumul
select v.*, sum(CA) over(order by CA desc) as cumul
from v_ca_tiers v;
    
-- Rang
select v.*, sum(CA) over(order by CA desc) as cumul, rank() over(order by CA) as Rang
from v_ca_tiers v;

--- with
with v1(annee,numero,tiers,CA) as 
    (select extract(year from c.dateCommande) as annee, t.numeroTiers as numero,
    t.nomTiers as Tiers, sum(l.quantite * a.prixUnitaire) as CA
    from commande c, tiers t, ligneCommande l, article a
    where (c.tiers_id = t.id and l.commande_id = c.id and l.article_id = a.id)
    and c.typeCommande = 'VTE'
    group by annee, numero, tiers),
    v2(annee, total) as
    (select extract(year from c.dateCommande) as annee, sum(l.quantite * a.prixUnitaire) as CA
    from commande c, ligneCommande l, article a
    where l.commande_id = c.id and l.article_id = a.id and c.typeCommande = 'VTE'
    group by annee)

    select v1.*, round((v1.CA/v2.total)*100,2)|| ' %' as Pourcentage
    from v1, v2
    where v1.annee = v2.annee;

--------- exemple 2 (with)

with v1(id, numeroArticle, designation) as
    (select id, numeroArticle, designation from article),
    v2(id,prixUnitaire) as
    (select id, prixUnitaire from article)
    select v1.*,v2.prixUnitaire from v1,v2 where v1.id=v2.id;

---- exemple 3 (requete equvalente au tp avec "if" et "case" vu précédemment)


--- (ne fonctionne pas)
with v1(Annee, Code, Article, PU) as
    (select extract(year from c.dateCommande) Annee, a.numeroArticle Code, 
		a.designation Article, a.prixUnitaire PU,
		sum(case when extract(month from c.dateCommande) = 1 then l.quantite else 0 end) as Janvier,
		sum(case when extract(month from c.dateCommande) = 2 then l.quantite else 0 end) as Février,
		sum(case when extract(month from c.dateCommande) = 3 then l.quantite else 0 end) as Mars,
		sum(case when extract(month from c.dateCommande) > 3 then l.quantite else 0 end) as Autres
        from article a, ligneCommande l, commande c
        where l.article_id = a.id and c.id = l.commande_id
        group by Code order by Annee, Code),

    v2(Annee, Code, Article, PU) as
    (select Annee, Code, Article, PU, sum(Janvier) as Janvier,
									sum(Février) as Février,
									sum(Mars) as Mars,
									sum(Autres) as Autres
    from v1
    group by Annee, Code);

    --- corrigé

    with v_intermediaire(article_id, annee, jan, fev, mars, autre) as
        (select l.article_id, extract(year from c.dateCommande), l.quantite,0,0,0
        from commande c, ligneCommande l
        where l.commande_id = c.id and extract(month from c.dateCommande) = 1
        union all
        select l.article_id, extract(year from c.dateCommande), 0,l.quantite,0,0
        from commande c, ligneCommande l
        where l.commande_id = c.id and extract(month from c.dateCommande) = 2
        union all
        select l.article_id, extract(year from c.dateCommande), 0,0,l.quantite,0
        from commande c, ligneCommande l
        where l.commande_id = c.id and extract(month from c.dateCommande) = 3
        union all
        select l.article_id, extract(year from c.dateCommande), 0,0,0,l.quantite
        from commande c, ligneCommande l
        where l.commande_id = c.id and extract(month from c.dateCommande) > 3
        )
        select v.annee as Annee, a.numeroArticle as Code, a.designation as Article, a.prixUnitaire as PU, 
            sum(v.jan) as jan, sum(v.fev) as fev, sum(v.mars) as mars, sum(v.autre) as autre, sum(jan+fev+mars+autre) as total 
        from article a, v_intermediaire v where v.article_id = a.id
        group by Annee, Code, Article, PU;