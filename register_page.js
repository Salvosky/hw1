function verificaCampi(event){
    const campo=event.currentTarget;
    let error;
    error=document.querySelector("#error");
    error.classList.add("hidden");
    if((campo['username'].value==0) || (campo['password'].value==0)
        || campo['nome'].value==0 || campo['cognome']==0
        || campo['confirm'].value==0 || campo['cf'].value==0){
        const p=error.querySelector("p");
        p.textContent="Inserire un valore in tutti i campi";
        error.classList.remove("hidden");
        event.preventDefault();
    }
    else if(!campo['check'].checked){
        const p=error.querySelector("p");
        p.textContent="Accettare i termini e le condizioni d'uso";
        error.classList.remove("hidden");
        event.preventDefault();
    }
    else if(campo['password'].value.length<8){
        const p=error.querySelector("p");
        p.textContent="Password troppo corta";
        error.classList.remove("hidden");
        event.preventDefault();
    }
    else if(campo['password'].value!==campo['confirm'].value){
        const p=error.querySelector("p");
        p.textContent="Le password non coincidono";
        error.classList.remove("hidden");
        event.preventDefault();
    }
    else if(isUpperCase(campo['password'].value)===null){
        const p=error.querySelector("p");
        p.textContent="La password non contiene maiscole e/o numeri";
        error.classList.remove("hidden");
        event.preventDefault();
    }
}

function isUpperCase(string){
     return (string.match(/[a-z]/) && string.match(/[A-Z]/) && string.match(/[0-9]/));
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
