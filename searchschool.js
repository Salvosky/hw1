function searchschool(event){
    //Se non c'è scritto nulla nel form, non faccio nulla
    //In ogni caso, evito il ricaricamento della pagina
    if(form.schoolname==0){
        event.preventDefault();
    }
    //Se invece c'è scritto qualcosa...
    else{
        //...creo la richiesta...
        const argument="?schoolname="+event.currentTarget.parentNode.querySelector("input").value;
        //e la inoltro
        fetch("http://localhost/searchschooldatabase.php"+argument).then(onResponse).then(onJson);
        event.preventDefault();
    }
}

function onResponse(response){
    if(response.ok){
        return response.json();
    }
}

function onJson(json){
    //Prendo il box dei risultati e lo resetto
    const box=document.querySelector("#result_box");
    box.innerHTML='';
    //Esamino ogni risultato ritornato
    for(const el of json){
        //Creo un blocco per ogni entry ritornata dalla fetch
        const result=document.createElement("div");
        result.id="result";
        const div=document.createElement("div");
        div.classList.add("text");
        div.textContent=el['Nome'];
        result.appendChild(div);
        const schoolid=document.createElement("div");
        schoolid.classList.add("hidden");
        schoolid.classList.add("id");
        schoolid.textContent=el['Id'];
        result.appendChild(schoolid);
        //Creo anche un testo che se cliccato genera un box di dettagli
        const dettagli=document.createElement("div");
        dettagli.classList.add("dettagli");
        dettagli.textContent="dettagli";
        dettagli.addEventListener("click", mostraDettagli);
        result.appendChild(dettagli);
        box.appendChild(result);
    }
}

function mostraDettagli(event){
    //Seleziono tutti i .details e mi assicuro che l'unico .details nascosto sia
    //quello cliccato
    const det=document.querySelectorAll(".dettagli");
    for(const d of det){
        if((d!==event.currentTarget) && (d.classList.contains("hidden"))){
            d.classList.remove("hidden");
            d.addEventListener("click", mostraDettagli);
        }
    }
    //Nascondo il .details cliccato
    event.currentTarget.classList.add("hidden");
    event.currentTarget.removeEventListener("click", mostraDettagli);
    //Creo una seconda fetch che mi ritorna i dettagli del blocco result selezionato
    const argument=event.currentTarget.parentNode.querySelector(".id").textContent;
    fetch("http://localhost/searchschooldatabase.php?Id="+argument).then(onResponse).then(onJsonDettagli);
}

function nascondiDettagli(event){
    //Rimuovo l'event listener
    event.currentTarget.removeEventListener("click", nascondiDettagli);
    //Rimuovo ogni classe hidden dai .details
    const details=document.querySelectorAll(".dettagli");
    for(const d of details){
        if(d.classList.contains("hidden")){
            d.classList.remove("hidden");
            d.addEventListener("click", mostraDettagli);
        }
    }
    //Nascondo il box dei dettagli
    const detail_box=document.querySelector("#details");
    detail_box.innerHTML="";
    detail_box.classList.add("hidden");
}

function onJsonDettagli(json){
    //Seleziono il box di dettagli e gli rimuovo la classe hidden
    const details=document.querySelector("#details");
    details.classList.remove("hidden");
    details.innerHTML='';
    //Seleziono il risultato della query (deve essere un solo risultato)
    console.log(json[0]);
    //Creo il testo del details
    const div=document.createElement("div");
    div.classList.add("text");
    const el=json[0];
    let ordine;
    let grado;
    if(el['Ordine']==1){
        ordine="primaria";
    }
    else{
        ordine="secondaria";
    }
    if(el['Grado']==1){
        grado="primo";
    }
    else{
        grado="secondo";
    }
    div.textContent=el['Nome']+", Scuola "+ordine+" di "+grado+" grado, Citta: "+el['Citta']+" in "+el['Via'];
    details.appendChild(div);
    //Creo un bottone per reindirizzarmi alla pagina della scuola tramite form
    const redirect=document.createElement("form");
    redirect.name="redirect";
    redirect.action="schooldetails.php";
    redirect.method="get";
    redirect.id="redirect";
    const button=document.createElement("input");
    button.type="submit";
    const hidden=document.createElement("input");
    hidden.name="Id_Scuola";
    hidden.type="hidden";
    hidden.value=el['Id'];
    redirect.appendChild(hidden);
    button.value="Vai alla pagina della scuola";
    redirect.appendChild(button);
    //const section=document.querySelector("section");
    details.appendChild(redirect);
    //Creo il testo per nascondere il blocco details
    const nascondi=document.createElement("div");
    nascondi.classList.add("nascondi");
    nascondi.textContent="nascondi";
    nascondi.addEventListener("click", nascondiDettagli);
    details.appendChild(nascondi);
}

//Seleziono il form
const form=document.querySelector("form");
//Gli aggiungo l'event listener al submit
form.addEventListener("submit", searchschool);
//Faccio richiesta al server per il primo caricamento
fetch("http://localhost/searchschooldatabase.php").then(onResponse).then(onJson);

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