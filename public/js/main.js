function autoHighlight(name_input) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            console.log(this.response)
        }
    };

    xhttp.open('POST' , `/search_name/${name_input}`)
    xhttp.send();
}