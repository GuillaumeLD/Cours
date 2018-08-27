export class AppareilService {
	tabAppareil =[
  	{name:'TV',status:'éteint'},
  	{name:'Playstation',status:'éteint'},
  	{name:'Xbox',status:'allumé'},
  	{name:'Machine à café',status:'allumé'}
  ];
  switchAllOn(){
  	for(let appareil of this.tabAppareil){
  		appareil.status = 'allumé';
  	}
  }
  switchAllOff(){
    for(let appareil of this.tabAppareil){
      appareil.status = 'éteint';
    }
  }
  switchOneOn(i:number){
    this.tabAppareil[i].status='allumé';
  }  
  switchOneOff(i:number){
    this.tabAppareil[i].status='éteint';
  }  
 
}