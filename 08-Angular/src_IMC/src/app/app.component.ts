import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
 poids:string;
 taille:string;
 tranche:string;
 imc:number;

 onCalculer(){
 	let poids2 = parseFloat(this.poids);
	let taille2 = parseFloat(this.taille);
	this.poids='';
	this.taille='';
	this.imc = poids2/(taille2*taille2);

	this.imc = Math.round(this.imc *100)/100;
	if (this.imc < 16){
  		this.tranche="annorexie";
  	}else if (this.imc < 18.5){
  		this.tranche="maigreur";
  	}else if(this.imc < 25){
  		this.tranche="normal";
  	}else if (this.imc < 30){
  		this.tranche="surpoids";
  	}else if (this.imc < 40){
  		this.tranche="obesite";
  	}else{
		this.tranche="massive";
  	} 

 }
}
