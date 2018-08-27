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
	enleverEquipe(e:Equipe){
		console.log(e);
		let tab =this.entreprise.tabEquipe;
		for(let equipe of tab){
			if(equipe == e){
				tab.splice(tab.indexOf(e),1);
			}
		}
	}
	enleverPersonne(id:number){
		let tab = this.entreprise.tabPersonne;
		for (let i in tab){
			if(id == tab[i].id){
				tab.splice(parseInt(i),1);
			}
		}
	}
}



