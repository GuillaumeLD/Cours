import { Component, OnInit, Input } from '@angular/core';
import {EntrepriseService} from '../services/entreprise.service';
@Component({
  selector: 'app-equipe',
  templateUrl: './equipe.component.html',
  styleUrls: ['./equipe.component.scss']
})
export class EquipeComponent implements OnInit {
@Input() equipe:any;

  constructor(private entrepriseService:EntrepriseService) { }

  ngOnInit() {
  }

  onEnleverEquipe(){
  	this.entrepriseService.enleverEquipe(this.equipe);
  }
}
