var page = document.getElementById("page-top");
var maDiv = document.createElement("div");
maDiv.innerHTML = "ma Div";
maDiv.addEventListener("click", function() {
    maDiv.innerHTML = "j'ai cliqué";
})
page.appendChild(maDiv);