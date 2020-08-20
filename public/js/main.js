function autoHighlight(name_input) {

    if(name_input == null || name_input == ''){
        return;
    }

    var students = document.querySelectorAll('.students');
    
    for(a of students){
        a.style.backgroundColor = 'transparent';
    }


    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            answer = JSON.parse(this.response);
            
            for(student of answer){
                var element = document.getElementById(student.id);
                element.style.backgroundColor = 'rgba(255,0,0,0.4)';
            }
        }
    };

    xhttp.open('POST' , `/search_name/${name_input}`);
    xhttp.send();
}

function student_add(){
    var form = document.querySelector('aside.studentform');
    form.classList.toggle('show');
}

function showInfo(element) {
    var studentId = element.id;
    var name = element.innerHTML;
    var namn = document.querySelector(".name");
    namn.innerHTML = name;
    var userImg = `url('../img/students/${studentId}.jpg')`;
    var container = document.querySelector(".personImg");
    container.style.backgroundImage = userImg;
}