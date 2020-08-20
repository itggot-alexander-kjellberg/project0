function autoHighlight(name_input) {

    var students = document.querySelectorAll('.students');
    if(name_input == null || name_input == ''){
        for(a of students){
            a.style.backgroundColor = 'transparent';
        }
        return;
    }

    
    for(a of students){
        a.style.backgroundColor = 'transparent';
    }


    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            answer = JSON.parse(this.response);
            
            for(student of answer){
                var element = document.getElementById(student.id);
                element.style.backgroundColor = 'rgba(255,255,0,0.7)';
            }
        }
    };

    xhttp.open('POST' , `/search_name/${name_input}`);
    xhttp.send();
}

function student_add(){
    var form = document.querySelector('form.student_form');
    form.classList.toggle('hide');
}

function trait(self){
    var el = document.createElement('input');
    el.classList.add('student_char');
    el.placeholder = 'Character trait'
    var i = document.querySelectorAll('input.student_char').length;
    el.setAttribute('name', `char${i}`);

    self.parentNode.insertBefore(el, self);
}

function showInfo(element) {
    console.log(element);
    var studentId = element.id;
    var name = element.innerHTML;
    console.log(name);
    var el = document.querySelector(".personImg");
    console.log(el);
    
    el.style.backgroundImage = `url('../img/students/${studentId}.jpg')`;
}