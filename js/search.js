const elements = document.getElementsByClassName('item');
const button = document.getElementById("search");
const field = document.getElementById("searchField");

var search = function(event) {
    event.preventDefault();
    var terms = field.value;
    var tokens = terms
        .toLowerCase()
        .split(' ')
        .filter(function(token){
            return token.trim() !== '';
        });
    if(tokens.length) {
        var searchTermRegex = new RegExp(tokens.join('|'), 'gim');
        for (count = 0; count < elements.length; count++){
            if (elements[count].innerText.match(searchTermRegex))
                elements[count].removeAttribute("hidden");
            else
                elements[count].setAttribute("hidden", true);
        }
    }
}
document.addEventListener('submit', search)