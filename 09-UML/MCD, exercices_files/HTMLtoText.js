// JavaScript Document
function HTMLtoText(chaine){
 var reg=new RegExp("(<br>)", "g");
 var regBis=new RegExp("(<BR>)", "g");
 var reg1=new RegExp("(&lt;)", "g"); 
 var reg2=new RegExp("(&gt;)", "g"); 
 chaine=chaine.replace(reg,"");
 chaine=chaine.replace(regBis,"\n");
 chaine=chaine.replace(reg1,"<");
 chaine=chaine.replace(reg2,">");
 return chaine;
}