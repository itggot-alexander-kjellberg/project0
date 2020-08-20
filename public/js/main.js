function autoHighlight(name_input) {

    if(name_input == null || name_input == ''){
        return
    }

    var students = document.querySelectorAll('a.students');
    
    for(a of students){
        a.style.backgroundColor = 'transparent'
    }


    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            answer = JSON.parse(this.response)
            
            for(student of answer){
                var element = document.getElementById(student.id)
                element.style.backgroundColor = 'rgba(255,0,0,0.4)';
            }
        }
    };

    xhttp.open('POST' , `/search_name/${name_input}`)
    xhttp.send();
}

function student_add(){
    var form = document.querySelector('aside.studentform');
    form.classList.toggle('show');
}