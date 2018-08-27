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