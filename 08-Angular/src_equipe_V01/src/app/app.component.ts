import { Component } from '@angular/core';
import { Personne } from './models/personne';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  tabEquipe = [
  	{
  		name:'Team A',
  		tabPersonne:[
  			{nom:'Doe',prenom:'John'},
  			{nom:'PITT',prenom:'Brad'}
  		]
  	},
  	{
  		name:'Team B',
  		tabPersonne:[]
  	}
  ];

  onTest(){
    let personne = new Personne('CRUISE','Tom');
    console.log(personne);
  }
}
