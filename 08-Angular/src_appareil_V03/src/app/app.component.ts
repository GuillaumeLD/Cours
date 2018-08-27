import { Component ,OnInit } from '@angular/core';
import { AppareilService} from './services/appareil.service';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{
  tabAppareil:any[];

  constructor(private appareilService:AppareilService){

  }

  ngOnInit(){
  	// je recupere le tableau du service
  	this.tabAppareil=this.appareilService.tabAppareil;
  }
  onAllumer(){
  	this.appareilService.switchAllOn();
  }
  onEteindre(){
    this.appareilService.switchAllOff();
  }
}
