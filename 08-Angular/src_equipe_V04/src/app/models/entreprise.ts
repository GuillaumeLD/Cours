import {Personne}  from './personne';
import {Equipe}  from './equipe';

export class Entreprise{
	tabPersonne:Personne[];
	tabEquipe:Equipe[];

	constructor(){
		this.tabPersonne=[];
		this.tabEquipe=[];
	}

}