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
            console.log(answer)
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

function student_add_menu(action){
    var form = document.querySelector('form.student_form');
    form.classList.toggle('hide');

    if(action == 'add'){
        form.setAttribute('action','/student/add')
    }else if(action == 'edit'){
        form.setAttribute('action','/student/edit')
    }
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

    var char_box = document.createElement('div');
    char_box.classList.add('char_box');

    var icon = document.createElement('i');
    icon.classList.add('material-icons')
    icon.innerHTML = 'remove_circle_outline';
    icon.setAttribute('onclick', 'char_remove(this)')

    char_box.appendChild(el)
    char_box.appendChild(icon)

    self.parentNode.insertBefore(char_box, self);
}

function showInfo(element) {
    var studentId = element.id;
    var name = element.innerHTML;
    var namn = document.querySelector(".name");
    namn.innerHTML = name;

    var requesten = new XMLHttpRequest();
    requesten.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            var container = document.querySelector(".personImg");
            answer = this.response;
            if(answer == 'true') {
                var userImg = `url('../img/students/${studentId}.jpg')`;
            } else {
                var userImg = `url('../img/standarduser.png')`;
            }
            container.style.backgroundImage = userImg;
        };
    };
    requesten.open('POST' , `/userimg/${studentId}`);
    requesten.send();

    var leButton = document.querySelector(".remove_student");
    leButton.setAttribute("id", studentId);
    document.querySelector("#removeId").setAttribute("value", studentId);
}

// function checkUserImg(id) {
//     var requesten = new XMLHttpRequest();
//     requesten.onreadystatechange = function(){
//         if(this.readyState == 4 && this.status == 200){
//             answer = this.response;
//             console.log(answer);
//         };
//     };
//     requesten.open('POST', `/userImg/${id}`);
//     requesten.send();
// }

function class_change(self){
    
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){     
            answer = JSON.parse(this.response);
            console.log(answer.length)



            var parent = document.querySelector('.student_box');
            
            while (parent.firstChild){
                parent.removeChild(parent.lastChild);
            }

            if (answer.length == 0){
                var child = document.createElement('p');
                child.textContent = 'There are no memebers in this class!'
                parent.appendChild(child);
                return
            }

            for(student of answer){
                var el = document.createElement('div');
                el.classList.add('students');
                el.setAttribute('id', student.id);
                el.setAttribute('onclick', 'showInfo(this)');
                el.innerHTML = student.name

                parent.appendChild(el)
            }

            console.log(answer)
        }
    };

    xhttp.open('POST' , `/class_change/${self.value}`);
    xhttp.send();

    // console.log(self.value)


}

function student_edit_displayName(){
    var name = document.querySelector(".name").innerHTML;
    document.querySelector("#studentName").innerHTML = ("Edit "+name+"'s"+" traits")
}

function char_remove(self){
    self.parentNode.parentNode.removeChild(self.parentNode)
}