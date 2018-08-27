import {Entreprise} from '../models/entreprise';
import {Equipe} from '../models/equipe';
import {Personne} from '../models/personne';

import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable()
export class EntrepriseService{
	private entreprise= new Entreprise();

	entrepriseSubject = new Subject();

	constructor(private httpClient:HttpClient){
		
	}
	emitEntrepriseSubject(){
		this.entrepriseSubject.next(this.entreprise);
	}

	ajouterEquipe(e:Equipe){
		this.entreprise.tabEquipe.push(e);
		this.emitEntrepriseSubject();
	}
	ajouterPersonne(p:Personne){
		this.entreprise.tabPersonne.push(p);
		this.emitEntrepriseSubject();
	}
	ajouterPersonneEquipe(equipeId:number,p:Personne){
		// trouver la bonne equipe
		for(let e of this.entreprise.tabEquipe){
			if(e.id == equipeId){
				e.tabPersonne.push(p);
			}
		}
		this.emitEntrepriseSubject();
	}
	enleverEquipe(e:Equipe){
		console.log(e);
		let tab =this.entreprise.tabEquipe;
		for(let equipe of tab){
			if(equipe == e){
				tab.splice(tab.indexOf(e),1);
			}
		}
		this.emitEntrepriseSubject();
	}
	enleverPersonne(id:number){
		let tab = this.entreprise.tabPersonne;
		for (let i in tab){
			if(id == tab[i].id){
				tab.splice(parseInt(i),1);
			}
		}
		this.emitEntrepriseSubject();
	}

	 saveBdd(){
    this.httpClient
    .put("https://gestion-equipe.firebaseio.com/entreprise.json",
      this.entreprise)
    .subscribe(
      () => {
        console.log("ok");
      },(error)=>{
        console.log('error');
      }
    );
    }
   loadBdd(){
     this.httpClient
    .get<Entreprise>("https://gestion-equipe.firebaseio.com/entreprise.json")
    .subscribe(
      (response) => {
        this.entreprise=response;
        // verifier tabEquipe
        console.log(this.entreprise);
        //------------------------------------
        if (this.entreprise == undefined){
          this.entreprise = new Entreprise();
        }else{
          if(this.entreprise.tabEquipe == undefined){
             this.entreprise.tabEquipe=[];
          }
         if(this.entreprise.tabPersonne == undefined){
             this.entreprise.tabPersonne=[];
          }
        }
        //------------------------------------
        
        for (let e of this.entreprise.tabEquipe){
        	if(e.tabPersonne ==undefined){
        		e.tabPersonne=[];
        	}
        }
       
        console.log(this.entreprise);
        this.emitEntrepriseSubject();
        console.log(response);
      },(error)=>{
        console.log('error');
      }
    );
    }
}



