import { Component, OnInit, Input } from '@angular/core';
import { AppareilService } from '../services/appareil.service';
@Component({
  selector: 'app-appareil',
  templateUrl: './appareil.component.html',
  styleUrls: ['./appareil.component.scss']
})
export class AppareilComponent implements OnInit {
@Input()	appareil:any;
@Input() 	indexOfAppareil:number;
	
  constructor(private appareilService:AppareilService) { }

  ngOnInit() {
  }

  onAllumer(){
  	this.appareilService.switchOneOn(this.indexOfAppareil);
  }
  onEteindre(){
  	this.appareilService.switchOneOff(this.indexOfAppareil);
  }

   onSwitch(){

     if(this.appareil.status === 'allumé'){
       this.onEteindre();
     }else{
       this.onAllumer();
     }
   }
   getButtonText(){
    if(this.appareil.status === 'allumé'){
      return 'OFF';
    }else{
      return 'ON';
    }

   }  

   
}
