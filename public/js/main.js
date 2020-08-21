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
            console.log(answer);
            
            for(student of answer){
                var element = document.getElementById(student.id);
                element.style.backgroundColor = 'rgba(255,255,0,0.7)';
            }
        }
    };

    xhttp.open('POST' , `/search_name/${name_input}`);
    xhttp.send();
}

function trait_search(name_input){
    var students = document.querySelectorAll('.students');
    for(a of students){
        a.style.backgroundColor = 'transparent';
    }
    
    if(name_input == null || name_input == ''){
        return;
    }
    
    console.log(name_input)

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            answer = JSON.parse(this.response);
            console.log(answer);
            
            for(student of answer){
                var element = document.getElementById(student.student_id);
                element.style.backgroundColor = 'rgba(0,0,255,0.7)';
            }
        }
    };

    xhttp.open('POST' , `/search_trait/${name_input}`);
    xhttp.send();
}

function studentTraitGenerator(id){


    var parent = document.querySelector('aside.traitParent');
    var old_kidz = parent.children;

    while (parent.firstChild){
        parent.removeChild(parent.lastChild);
    }
    
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            
            
            answer = JSON.parse(this.response);
            
            for(trait of answer){
                var el = document.createElement('p');
                el.innerHTML = trait.name
                console.log(trait.name)
                parent.appendChild(el)
            }
        }
    };

    xhttp.open('POST' , `/student_trait_generator/${id}`);
    xhttp.send();
}

function student_add_menu(){
    var form = document.querySelector('form.student_form');
    form.classList.toggle('hide');
}

// hur kallar man på ruby/db_handler? Kan man?
function student_remove(element) {
    studentId = element.id;
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
    var studentId = element.id;
    var name = element.innerHTML;
    var namn = document.querySelector(".name");
    namn.innerHTML = name;
    var userImg = `url('../img/students/${studentId}.jpg')`;
    var container = document.querySelector(".personImg");
    container.style.backgroundImage = userImg;
    var leButton = document.querySelector(".remove_student");
    leButton.setAttribute("id", studentId);
    document.querySelector("#removeId").setAttribute("value", studentId);
}