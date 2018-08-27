import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  tabAppareil =[
  	{name:'TV',status:'éteint'},
  	{name:'Playstation',status:'allumé'},
  	{name:'Xbox',status:'allumé'},
  	{name:'Machine à café',status:'allumé'}
  ];
}
