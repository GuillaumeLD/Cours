var tableau = [10];
tableau.push(123);
tableau.push(124);
tableau.push(125);
tableau["key"] = 999;

tableau.forEach(function(val) {
    console.log("val ",val);
})

console.log("tableau[3] = ", tableau[3]);
console.log("tableau[key] = ", tableau["key"]);
console.log("Longueur de tableau = ", tableau.length);