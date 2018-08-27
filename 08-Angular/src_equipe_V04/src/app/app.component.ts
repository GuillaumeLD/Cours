import { Component ,OnInit } from '@angular/core';
import { Personne } from './models/personne';
import { Equipe} from './models/equipe';
import { Entreprise} from './models/entreprise';
import { NgForm} from '@angular/forms';
import {EntrepriseService} from './services/entreprise.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{
  teamName:string;
  entreprise:Entreprise;
  equipeId =0;
  personneId = 0;
  equipeDefault=0;
  constructor(private entrepriseService:EntrepriseService){
  }

  ngOnInit(){
    this.entreprise = this.entrepriseService.entreprise;
  }

  onAjouterEquipe(){
    this.equipeId++;
    let equipe = new Equipe (this.equipeId,this.teamName);
    this.teamName=''; // je vide le champ input
    //this.entreprise.tabEquipe.push(equipe);
    this.entrepriseService.ajouterEquipe(equipe);
   }
  onAjouterPersonne(form:NgForm){
    this.personneId++;
    let personne = new Personne(this.personneId,form.value["nom"],form.value["prenom"]);
    this.entrepriseService.ajouterPersonne(personne);
    form.controls['nom'].reset();
    form.controls['prenom'].reset();
    // je recupere l equipe Id du select
    let formEquipeId = form.value["equipe"];
    form.controls['equipe'].setValue(0);
    if(formEquipeId != 0){
      this.entrepriseService.ajouterPersonneEquipe(formEquipeId,personne);
    }
  }
  estDansEquipe(id:number){
    let test = false;
    for(let e of this.entreprise.tabEquipe){
      for(let p of e.tabPersonne){
        if (p.id == id ){
          test = true;
          break;
        }
      }
    }
    return test;
  }
  onEnleverPersonne(id:number){
    if (confirm('Etes vous sur ?')){

      // verifie si la personne est ds une equipe
      if (this.estDansEquipe(id)){
        alert ('Cette personne est deja ds une equipe');
      }else{
        this.entrepriseService.enleverPersonne(id);
      }
    }
  }

}
