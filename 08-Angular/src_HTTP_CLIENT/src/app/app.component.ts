import { Component , OnInit } from '@angular/core';
import { PersonneService} from './services/personne.service';
import{ Subscription} from 'rxjs';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{
  personne:any;
  personneSubscription:Subscription; 

  constructor(private personneService:PersonneService){

  }

  ngOnInit(){
  	//this.personne = this.personneService.personne;
  	this.personneSubscription = 
    this.personneService.personneSubject.subscribe(
      (p: any)=>{
        this.personne = p;
      }
      );
    this.personneService.emitPersonneSubject();

  }
  onSaveBdd(){
    this.personneService.saveBdd();
  }
  onLoadBdd(){
      this.personneService.loadBdd();
  }
}
