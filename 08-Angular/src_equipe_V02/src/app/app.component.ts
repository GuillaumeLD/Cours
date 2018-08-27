import { Component } from '@angular/core';
import { Personne } from './models/personne';
import { Equipe} from './models/equipe';
import { Entreprise} from './models/entreprise';
import { NgForm} from '@angular/forms';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  teamName:string;
  entreprise = new Entreprise();
  equipeId =0;

  onAjouterEquipe(){
    this.equipeId++;
    let equipe = new Equipe (this.equipeId,this.teamName);
    this.teamName=''; // je vide le champ input
    this.entreprise.tabEquipe.push(equipe);
    console.log(this.entreprise);
  }
  onAjouterPersonne(form:NgForm){
    console.log(form.value["nom"]);
    console.log(form.value["prenom"]);
    console.log(form.value["equipe"]);
  }

}
