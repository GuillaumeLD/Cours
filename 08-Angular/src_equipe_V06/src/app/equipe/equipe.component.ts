import { Component, OnInit, Input } from '@angular/core';
import {EntrepriseService} from '../services/entreprise.service';
import{ Subscription} from 'rxjs';
import{ Entreprise} from '../models/entreprise';
import{ Personne} from '../models/personne';
import {NgForm} from '@angular/forms';
@Component({
  selector: 'app-equipe',
  templateUrl: './equipe.component.html',
  styleUrls: ['./equipe.component.scss']
})
export class EquipeComponent implements OnInit {
	@Input() equipe:any;
 	entreprise:Entreprise;
	entrepriseSubscription =  new Subscription();
  constructor(private entrepriseService:EntrepriseService) { }

  ngOnInit() {
  	    this.entrepriseSubscription = 
    this.entrepriseService.entrepriseSubject.subscribe(
      (e: Entreprise)=>{
        this.entreprise = e;
      }
      );
    this.entrepriseService.emitEntrepriseSubject();

  }

  onEnleverEquipe(){
  	this.entrepriseService.enleverEquipe(this.equipe);
  }
  onAjouterPersonne(form:NgForm){
  	let p = form.value["personne"];
  	
  	this.entrepriseService.ajouterPersonneEquipe(this.equipe.id,p)
  }
  notInEquipe(p:Personne){
  	let test = true;
  	for (let personne of this.equipe.tabPersonne){
  		if (p.id == personne.id){
  			test=false;
  		}
  	}
  	return test;
  }
  getListPersonne(){
  	console.log('ola');
  	let tabPersonne:Personne[]=[];
  	for (let p of this.entreprise.tabPersonne){
  		// si p n est pas ds l Equipe
  		if(this.notInEquipe(p)){
  			tabPersonne.push(p);
  		}
  	}
  	return tabPersonne;
  }
}
