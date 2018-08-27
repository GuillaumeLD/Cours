function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
  }

var i=0;
while (i!=-1) {
    nombreObtenu = getRandomInt(0,100);
    if (nombreObtenu != 50) {
        i++;
    }
    else {
        nombreTest = i;
        console.log("Nombre 5 obtenu après ",nombreTest, " tentatives");
        i = -1;
    }
}

console.log(getRandomInt(40,60));
