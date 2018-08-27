import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class PersonneService {
	private personne = {
				nom: 'CRUISE',
				prenom :'Tom'
			};

	 personneSubject = new Subject();

	constructor(private httpClient:HttpClient){}

	 emitPersonneSubject(){
		this.personneSubject.next(this.personne);
	}

	saveBdd(){
		this.httpClient
		.put("https://gestion-equipe.firebaseio.com/personne.json",
			this.personne)
		.subscribe(
			() => {
				console.log("ok");
				//	this.appareils=response;
			},(error)=>{
				console.log('error');
			}
		);
	}
		loadBdd(){
		this.httpClient
		.get<any>("https://gestion-equipe.firebaseio.com/personne.json")
		.subscribe(
			(response) => {
				this.personne=response;
				this.emitPersonneSubject();
				console.log(response);
			},(error)=>{
				console.log('error');
			}
		);
	
	}
}




