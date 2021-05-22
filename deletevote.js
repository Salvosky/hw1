function onResponse(response){
    if(response.ok){
        return response.json();
    }
}

function onJson(json){
    const error=document.createElement("div");
    error.id="error";
    error.classList.add("hidden");
    showteacher.appendChild(error);
    error.textContent="Scegliere uno o più campi";
    //console.log(json);
    const deletediv=document.createElement("div");
    deletediv.id="delete";
    const form=document.createElement("form");
    form.name="deletevote";
    form.method="post";
    deletediv.appendChild(form);
    showteacher.appendChild(deletediv);
    for(const el of json){
        const label=document.createElement("label");
        const input=document.createElement("input");
        input.type="checkbox";
        input.name="voti[]";
        input.value=el['codice'];
        label.appendChild(input);
        const text=document.createElement("p");
        text.classList.add("text");
        label.appendChild(text);
        text.textContent=el['nomemateria']+": Voto: "+el['voto']+
        ", assegnato all'alunno "+el['nome_alunno']+" "+
        el['cognome_alunno']+" e registrato in data "+el['data'];
        form.appendChild(label);
    }
    const submit=document.createElement("input");
    submit.type="submit";
    submit.value="Rimuovi selezionati";
    form.appendChild(submit);
    form.addEventListener("submit", checkCampi);
}

function checkCampi(event){
    const form=document.querySelector("form");
    const error=document.querySelector("#error");
    error.classList.add("hidden");
    let checked=false;
    for(const el of form['voti[]']){
        console.log(el.value);
        if(el.checked!=0){
            checked=true;
        }
    }
    if(!checked){
        event.preventDefault();
        console.log("NO");
        error.classList.remove("hidden");
    }
}

if(document.querySelector("#showteacher")){
    const showteacher=document.querySelector("#showteacher");
    const argument=showteacher.querySelector("#argument").textContent;
    fetch("seekvotesteacher.php?argument="+argument).then(onResponse).then(onJson);
}


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