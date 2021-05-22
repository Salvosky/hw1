function instanzia(){
    const year=2021;
    fetch("holidays.php"+"?year="+year)
    .then(onResponse)
    .then(onJsonistanzia);
}

function istanziadata(){
    const year=document.querySelector("div.researches input").value;
    if(year && year>=1970 && year<=2049){
        fetch("holidays.php"+"?year="+year)
        .then(onResponse)
        .then(onJsonistanziadata);
    }
}

function onJsonistanzia(json){
    console.log(json);
    harray=json;
    const ricerca=document.querySelector("#ricercaNormale");
    ricerca.addEventListener("click", callVacanze);
}

function onJsonistanziadata(json){
    console.log(json);
    harraydata=json;
    const ricerca=document.querySelector("#ricercaConData");
    ricerca.addEventListener("click", callVacanzeConData);
}

function callVacanze(){
    const results=document.querySelector("#vacanze div.results");
    results.parentNode.classList.remove("hidden");
    results.innerHTML="";
    const holidays=harray.response.holidays;
    const h2=document.createElement("h2");
    h2.textContent+="Risultati: ";
    results.appendChild(h2);
    for(const holiday of holidays){
        if(holiday.type[0]==="National holiday"){
            const h1=document.createElement("h1");
            h1.textContent+=holiday.name+" "+holiday.date.iso;
            results.appendChild(h1);
        }
    }
}

function callVacanzeConData(){
    const results=document.querySelector("#vacanze div.results");
    results.parentNode.classList.remove("hidden");
    results.innerHTML="";
    const holidays=harraydata.response.holidays;
    const h2=document.createElement("h2");
    h2.textContent+="Risultati: ";
    results.appendChild(h2);
    for(const holiday of holidays){
        if(holiday.type[0]==="National holiday"){
            const h1=document.createElement("h1");
            h1.textContent+=holiday.name+" "+holiday.date.iso;
            results.appendChild(h1);
        }
    }
}

function onResponse(response){
    console.log(response);
    if(response.ok){
        return response.json();
    }
}

let harray;
instanzia();
let harraydata;
const ricerca=document.querySelector("div.researches input");
ricerca.addEventListener("keyup", istanziadata);
