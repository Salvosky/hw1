function onResponse(response){
    if(response.ok){
        return response.json();
    }
}

function onJsonStudent(json){
    const table=document.createElement("table");
    table.id="result";
    const header=document.createElement("tr");
    const headers=["Materia", "Nome Insegnante","Cognome Insegnante","Voto","Data"];
    const arguments=['nomemateria', 'nome_insegnante', 'cognome_insegnante', 'voto', 'data'];
    for(let i=0;i<5;i++){
        const headerentry=document.createElement("th");
        headerentry.textContent=headers[i];
        header.appendChild(headerentry);
    }
    table.appendChild(header);
    for(const result of json){
        const row=document.createElement("tr");
        for(let i=0;i<5;i++){
            const entry=document.createElement("td");
            entry.textContent=result[arguments[i]];
            row.appendChild(entry);
        }
        table.appendChild(row);
    }
    showstudent.appendChild(table);
}

function onJsonTeacher(json){
    const table=document.createElement("table");
    table.id="result";
    const header=document.createElement("tr");
    const headers=["Materia", "Nome Alunno","Cognome Alunno","Voto","Data"];
    const arguments=['nomemateria', 'nome_alunno', 'cognome_alunno', 'voto', 'data'];
    for(let i=0;i<5;i++){
        const headerentry=document.createElement("th");
        headerentry.textContent=headers[i];
        header.appendChild(headerentry);
    }
    table.appendChild(header);
    for(const result of json){
        const row=document.createElement("tr");
        for(let i=0;i<5;i++){
            const entry=document.createElement("td");
            entry.textContent=result[arguments[i]];
            row.appendChild(entry);
        }
        table.appendChild(row);
    }
    showteacher.appendChild(table);
    const selection=document.createElement("div");
    selection.classList.add("selection");
    showteacher.appendChild(selection);
    const addvote=document.createElement("form");
    addvote.name="addvote";
    addvote.method="post";
    addvote.action="aggiungivoto.php";
    const submitadd=document.createElement("input");
    submitadd.type="submit";
    submitadd.value="Aggiungi voto";
    addvote.appendChild(submitadd);
    const deletevote=document.createElement("form");
    deletevote.name="deletevote";
    deletevote.method="post";
    deletevote.action="rimuovivoto.php";
    const submitdelete=document.createElement("input");
    submitdelete.type="submit";
    submitdelete.value="Rimuovi voto";
    deletevote.appendChild(submitdelete);
    selection.appendChild(addvote);
    selection.appendChild(deletevote);
}

if(document.querySelector("#showstudent")!=null){
    const showstudent=document.querySelector("#showstudent");
    const argument=showstudent.querySelector("#argument").textContent;
    fetch("seekvotes.php?argument="+argument).then(onResponse).then(onJsonStudent);
}
if(document.querySelector("#showteacher")!=null){
    const showteacher=document.querySelector("#showteacher");
    const argument=showteacher.querySelector("#argument").textContent;
    fetch("seekvotesteacher.php?argument="+argument).then(onResponse).then(onJsonTeacher);
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





