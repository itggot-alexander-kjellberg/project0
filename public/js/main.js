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
    var form = document.querySelector('form.student_form');
    form.classList.toggle('hide');
}

function trait(self){
    var i = document.querySelectorAll('input.student_char').length + 1
    var el = document.createElement('input');
    var parent = document.querySelector('form.student_form')

    el.placeholder = "Character trait";
    el.classList.add('student_char')
    el.setAttribute('name', `char${i}`);
    parent.insertBefore(el, self)
}