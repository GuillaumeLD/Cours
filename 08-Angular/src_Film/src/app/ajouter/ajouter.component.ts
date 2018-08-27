import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {CatalogueService} from '../services/catalogue.service';
@Component({
  selector: 'app-ajouter',
  templateUrl: './ajouter.component.html',
  styleUrls: ['./ajouter.component.scss']
})
export class AjouterComponent implements OnInit {
	film:string;
	tabFilm:any[];
  constructor(private httpClient:HttpClient,
  		private catalogueService:CatalogueService
  	){}

  ngOnInit() {
  }
  onAction(){
		let url = 'http://www.omdbapi.com/?apikey=efdc2275';
		url+='&s='+this.film;
		
		this.httpClient
		.get<any>(url)
		.subscribe(
			(response) => {
				//this.info =response.Title;
				this.tabFilm = response.Search;
				console.log(response);
			},(error)=>{
				console.log('error');
			}
		);

	}
	onAjouterFilm(film:any){
		let f:any ={};
		f.name = film.Title;
		f.image = film.Poster;
		this.catalogueService.ajouterFilm(f);
	}

}
