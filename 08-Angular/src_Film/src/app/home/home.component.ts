import { Component, OnInit } from '@angular/core';
import {CatalogueService} from '../services/catalogue.service';
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
	catalogue:any;
  constructor(private catalogueService:CatalogueService) { }

  ngOnInit() {
  	this.catalogue = this.catalogueService.catalogue;
  }

}
