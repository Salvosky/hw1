function onResponse(response){
    if(response.ok){
        return response.json();
    }
}

function onJson(json){
    const school=json[0];
    const titlebox=document.createElement("h1");
    titlebox.textContent=school.nome+" - "+school.via+" - "+school.citta;
    const sd=document.querySelector("#schooldetails");
    sd.appendChild(titlebox);
    if(document.querySelector("#average")!==null){
        const average=document.querySelector("#average");
        const titleaverage=document.createElement("h1");
        titleaverage.textContent="Media studenti per classe: "+average.textContent;
        sd.appendChild(titleaverage);
    }    
    const classes=document.createElement("div");
    classes.id="classes";
    sd.appendChild(classes);
    for(i=0;i<json.length;i++){
        const box=document.createElement("div");
        box.classList.add("box");
        const ap=document.createElement("a");
        if(document.querySelector("#login")!==null){
            ap.href="classpage.php?id_classe="+json[i].id_classe;
        }
        ap.textContent=json[i].anno+json[i].corso+" "+json[i].indirizzo;
        box.appendChild(ap);
        classes.appendChild(box);
    }
}

//Faccio richiesta alla pagina con il parametro get
if(window.location.search){
    fetch("seekschooldetails.php"+window.location.search).then(onResponse).then(onJson);
}
else{
    const h1=document.querySelector("h1");
    h1.textContent="Non è stata specificata nessuna scuola";
    const sd=document.querySelector("#schooldetails");
    sd.appendChild(h1);
    const a=document.createElement("a");
    a.textContent="Torna alla home";
    a.href="homepage.php";
    sd.appendChild(a);
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