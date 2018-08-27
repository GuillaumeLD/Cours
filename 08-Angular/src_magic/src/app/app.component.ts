import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  magic = Math.floor(Math.random() * 100) + 1; 
  nombre:string; 
  info:string;
  rejouer= false;

  onJouer(){
  	let nb = parseInt(this.nombre);
  	this.nombre='';

  	if (nb > this.magic){
  		this.info= 'Trop GRAND !';
  	}else if (nb < this.magic){
  		this.info= 'Trop petit !';
  	}
  	else if(nb == this.magic){
  		this.info= 'GAGNE';
  		this.rejouer= true;
  	}else{
  		this.info= '???';
  	}
  	
  }
  onReJouer(){
  	this.magic = Math.floor(Math.random() * 100) + 1;
  	this.rejouer=false; 
  }
}

