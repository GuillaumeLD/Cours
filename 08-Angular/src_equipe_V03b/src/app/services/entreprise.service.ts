import {Entreprise} from '../models/entreprise';
import {Equipe} from '../models/equipe';
import {Personne} from '../models/personne';
export class EntrepriseService{
	entreprise= new Entreprise();
	ajouterEquipe(e:Equipe){
		this.entreprise.tabEquipe.push(e);
	}
	ajouterPersonne(p:Personne){
		this.entreprise.tabPersonne.push(p);
	}
	ajouterPersonneEquipe(equipeId:number,p:Personne){
		// trouver la bonne equipe
		for(let e of this.entreprise.tabEquipe){
			if(e.id == equipeId){
				e.tabPersonne.push(p);
			}
		}
	}
}