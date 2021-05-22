function onResponse(response){
    if(response.ok){
        return response.json();
    }
}

function onJson(json){
    console.log(json);
    const details=document.createElement("div");
    details.id="details";
    const title=document.querySelector(".title");
    title.textContent+=" di "+json['username'];
    //details.textContent=json['username']+" - "+json['nome']+" - "+json['cognome'];
    const un=document.createElement("div");
    un.classList.add("box");
    un.textContent="Username: "+json['username'];
    details.appendChild(un);
    const name=document.createElement("div");
    name.classList.add("box");
    name.textContent="Nome: "+json['nome'];
    details.appendChild(name);
    const cog=document.createElement("div");
    cog.classList.add("box");
    cog.textContent="Cognome: "+json['cognome'];
    details.appendChild(cog);
    const cf=document.createElement("div");
    cf.classList.add("box");
    cf.textContent="Codice fiscale: "+json['cf'];
    details.appendChild(cf);
    const type=document.createElement("div");
    type.classList.add("box");
    type.textContent=" "+json['tipo'];
    details.appendChild(type);
    const profile_details=document.querySelector("#profile_details");
    profile_details.appendChild(details);
}

const profile=document.querySelector("#argument");
if(profile){
    const argument=document.querySelector("#argument").textContent;
    fetch("profile_search.php?username="+argument).then(onResponse).then(onJson);
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