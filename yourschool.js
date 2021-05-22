function onResponse(response){
    if(response.ok){
        return response.json();
    }
}

function onJson(json){
    //console.log(json);
    const titlebox=document.createElement("h1");
    titlebox.textContent=json.scuola;
    const sd=document.querySelector("#schooldetails");
    sd.appendChild(titlebox);
    const classes=document.createElement("div");
    classes.id="classes";
    sd.appendChild(classes);
    const box=document.createElement("div");
    box.classList.add("box");
    const ap=document.createElement("a");
    //console.log(document.querySelector("#login"));
    if(document.querySelector("#login")!==null){
        ap.href="classpage.php?id_classe="+json.id_classe;
    }
    ap.textContent="La tua classe: "+json.anno+json.corso+" "+json.indirizzo;
    box.appendChild(ap);
    classes.appendChild(box);
}

const codfis=document.querySelector("#result").textContent;
if(codfis!=null){
    fetch("seeksyourschooldetails.php?Cf="+codfis).then(onResponse).then(onJson);
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