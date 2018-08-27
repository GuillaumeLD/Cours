export class CatalogueService{
	catalogue = {
		tabFilm : []
	}
	
	ajouterFilm(film:any){
		this.catalogue.tabFilm.push(film);
	}
}