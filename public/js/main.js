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
    console.log(element);
    var studentId = element.id;
    var name = element.innerHTML;
    console.log(name);
    var el = document.querySelector(".personImg");
    console.log(el);
    
    el.style.backgroundImage = `url('../img/students/${studentId}.jpg')`;
}