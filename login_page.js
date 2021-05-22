function verificaCampi(event){
    const campo=event.currentTarget;
    console.log(campo['remember'].checked);
    let error;
    error=document.querySelector("#empty");
    error.classList.add("hidden");
    if((campo['username'].value==0) || (campo['password'].value==0)){
        error=document.querySelector("#empty");
        error.classList.remove("hidden");
        event.preventDefault();
    }
}

const form=document.querySelector("form");
form.addEventListener("submit", verificaCampi);

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