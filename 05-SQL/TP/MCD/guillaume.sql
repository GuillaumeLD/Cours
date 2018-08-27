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