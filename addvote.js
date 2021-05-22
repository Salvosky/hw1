function checkForm(event){
    const error=document.querySelector("#error");
    error.classList.add("hidden");
    if(form['date'].value==0 || form['materie'].value==="" || form['alunno'].value===""){
        error.classList.remove("hidden");
        event.preventDefault();
    }
}

const form=document.querySelector("form");
form.addEventListener("submit", checkForm);

function mostramenu(event){
    event.currentTarget.removeEventListener("click", mostramenu);
    const menu=document.querySelector("#menutendina");
    menu.classList.remove("hidden");
    event.currentTarget.addEventListener("click", nascondimenu);
}

function nascondimenu(event){
    event.currentTarget.removeEventListener("click", nascondimenu);
    const menu=document.querySelector("#menutendina");
    menu.classList.add("hidden");
    event.currentTarget.addEventListener("click", mostramenu);
}

const tendina=document.querySelector("#tendina");
tendina.addEventListener("click", mostramenu);