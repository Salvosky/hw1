function primoCaricamento(content){
    //Seleziono il blocco div di classe general
    const general=document.querySelector("div.general");
    //Istanzio tutte le notizie contenute di content.js nel div general
    for(let i=0; i<content.length; i++){
        //Recupero la i-esima notizia
        const titolo=content[i].titolo;
        const immagine=content[i].immagine;
        const testo=content[i].testo;
        const notice=creaBloccoNotice(titolo, immagine, testo);
        //Cerco se sono già stati istanziati blocchi container
        const generalcont=document.querySelector("div.general div.container");
        //Se ci sono, vediamo se ve ne sono di libere
        if(generalcont){
            //Li seleziono
            const container=document.querySelectorAll("div.general div.container");
            //Vedo quanti blocchi div notice sono contenuti in ogni blocco container
            let occupato=true;
            for(const el of container){
                //Verifico se il blocco è un container...
                if(el.classList.value.includes("container")){
                    let n_notice=0;
                    n_notice=el.childNodes.length;
                    //...e se vi sono meno di due blocchi notice in esso copio il blocco in quel container
                    if(n_notice<2){
                        el.appendChild(notice);
                        occupato=false;
                    }
                }
            }
            //Se non vi sono container liberi, ne creo uno
            if(occupato){
                //Creo un nuovo container...
                const divcont=document.createElement("div");
                divcont.classList.add("container");
                //...e lo appendo al blocco favourite...
                const gen=document.querySelector("div.general");
                gen.appendChild(divcont);
                //...e metto il blocco in quello appena creato
                divcont.appendChild(notice);
            }
        }
        //Se non ve ne sono, li creiamo
        else
        {
            //Creo il container e lo metto nel div general
            const cont=document.createElement("div");
            cont.classList.add("container");
            general.appendChild(cont);
            //E gli inserisco la notizia
            cont.appendChild(notice);
        }
    }
}

function mostraDettagli(event){
    //Recupero chi ha chiamato l'handler
    const dettagli=event.currentTarget;
    //Tolgo l'eventListener
    dettagli.removeEventListener("click", mostraDettagli);
    //Risalgo il DOM e applico il cambio di visibilità
    dettagli.classList.add("hidden");
    const nascondi=dettagli.parentNode.querySelector(".nascondi");
    nascondi.classList.remove("hidden");
    const testo=dettagli.parentNode.querySelector(".testo");
    testo.classList.remove("hidden");
    //E infine inserisco l'eventListener per rendere tutto invisibile di nuovo
    nascondi.addEventListener("click", nascondiDettagli);
}

function nascondiDettagli(event){
    //Recupero chi ha chiamato l'handler
    const nascondi=event.currentTarget;
    //Tolgo l'eventListener
    nascondi.removeEventListener("click", nascondiDettagli);
    //Risalgo il DOM e applico il cambio di visibilità
    nascondi.classList.add("hidden");
    const dettagli=nascondi.parentNode.querySelector(".dettagli");
    dettagli.classList.remove("hidden");
    const testo=nascondi.parentNode.querySelector(".testo");
    testo.classList.add("hidden");
    //E infine inserisco l'eventListener per rendere tutto visibile di nuovo
    dettagli.addEventListener("click", mostraDettagli);
}

function addFavourite(event){
    //Seleziono l'icona cliccata e rimuovo l'handler addFavourite
    const noticefav_icon=event.currentTarget;
    noticefav_icon.removeEventListener("click", addFavourite);
    //Risalgo due volte l'albero DOM e seleziono il div di classe notice e lo clono
    const noticefav=event.currentTarget.parentNode.parentNode.cloneNode(true);
    //Aggiungo le funzioni dettagli per il nuovo elemento
    noticefav.querySelector(".dettagli").addEventListener("click", mostraDettagli);
    noticefav.querySelector(".nascondi").addEventListener("click", nascondiDettagli);
    //Controllo se esiste nel div di classe favourite un elemento div di classe container
    if(document.querySelector("div.favourite div.container")){
        //Se esiste o esistono li seleziono
        const container=document.querySelectorAll("div.favourite div.container");
        //Vedo quanti blocchi div di classe notice sono contenuti in ogni blocco container
        //Introduco un booleano per la verifica di blocchi container disponobili
        let occupato=true;
        for(const el of container){
            //Verifico se il blocco è un container...
            if(el.classList.value.includes("container")){
                let n_notice=0;
                n_notice=el.childNodes.length;
                //...e se vi sono meno di due blocchi notice in esso copio il blocco in quel container
                if(n_notice<2){
                    el.appendChild(noticefav);
                    occupato=false;
                }
            }
        }
        //Se non vi sono container liberi, ne creo uno
        if(occupato){
            //Creo un nuovo container...
            const divcont=document.createElement("div");
            divcont.classList.add("container");
            //...e lo appendo al blocco favourite...
            const fav=document.querySelector("div.favourite");
            fav.appendChild(divcont);
            //...e metto il blocco in quello appena creato
            divcont.appendChild(noticefav);
        }
    }
    //Se, invece, non vi sono blocchi container (per esempio al primo caricamento della pagina), ne creo uno nuovo
    else
    {
        //Creo il nuovo container...
        const favcont=document.createElement("div");
        favcont.classList.add("container");
        const fav=document.querySelector("div.favourite");
        //...e lo inserisco nel blocco favourite rendendolo visibile
        fav.appendChild(favcont);
        favcont.appendChild(noticefav);
        fav.classList.remove("hidden");
    }
    //Seleziono le icone delle notizie nel blocco favourite
    const fav=document.querySelectorAll("div.favourite div.fav_icon");
    //Inserisco in ognuno l'handler del removeFavourite
    for(const el of fav){
        el.classList.remove("fav_icon");
        el.classList.add("unfav_icon");
        el.addEventListener("click", removeFavourite);
    }
}

function removeFavourite(event){
    //Seleziono l'icona cliccata e rimuovo l'handler del removeFavourite
    const unfav=event.currentTarget;
    unfav.removeEventListener("click", removeFavourite);
    //Elimino il blocco
    unfav.parentNode.parentNode.remove();
    //Seleziono tutti i container all'interno del blocco favourite...
    const container=document.querySelectorAll("div.favourite div.container");
    //...e controllo per ognuno se contengono blocchi notice
    for(const el of container){
        //Se il blocco è vuoto, lo rimuovo
        if(el.childNodes.length===0 || el.childNodes===undefined){
            el.remove();
        }
    }
    //Nascondo la sezione preferiti se non contiene nulla
    if(!document.querySelector("div.favourite div.container")){
        document.querySelector("div.favourite").classList.add("hidden");
    }
    //Per rimettere l'handler nel bottone della notizia appena rimossa...
    const favh=document.querySelectorAll("div.general div.notice");
    //...cerco nel blocco generale la notizia appena rimossa
    const compare1=unfav.parentNode.parentNode.querySelector("strong").textContent;
    for(const el of favh){
        let compare2= el.querySelector("strong").textContent;
        //Appena trovo la notizia, rimetto l'handler per riaggiungerlo nei preferiti
        if(compare1===compare2){
            el.querySelector(".fav_icon").addEventListener("click", addFavourite);
        }
    }
}

function creaBloccoNotice(tit, immag, tes){

    const notice=document.createElement("div");
    notice.classList.add("notice");

    const immagine=document.createElement("div");
    immagine.classList.add("immagine");
    notice.appendChild(immagine);

    const img=document.createElement("img");
    img.src=immag;
    immagine.appendChild(img);

    const fav_icon=document.createElement("div");
    fav_icon.classList.add("fav_icon");
    fav_icon.addEventListener("click", addFavourite);
    immagine.appendChild(fav_icon);

    const div_icon1=document.createElement("div");
    div_icon1.id="barra1";
    fav_icon.appendChild(div_icon1);
    
    const div_icon2=document.createElement("div");
    div_icon2.id="barra2";
    fav_icon.appendChild(div_icon2);

    const noticebar=document.createElement("div");
    noticebar.classList.add("noticebar");
    notice.appendChild(noticebar);

    const div=document.createElement("div");
    noticebar.appendChild(div);

    const title=document.createElement("strong");
    title.classList.add("title");
    title.textContent=tit;
    div.appendChild(title);
    
    const testo=document.createElement("div");
    testo.classList.add("testo");
    testo.classList.add("hidden");
    testo.textContent=tes;
    div.appendChild(testo);

    const dettagli=document.createElement("div");
    dettagli.classList.add("dettagli");
    dettagli.textContent="dettagli";
    noticebar.appendChild(dettagli);

    const nascondi=document.createElement("div");
    nascondi.classList.add("nascondi");
    nascondi.classList.add("hidden");
    nascondi.textContent="nascondi";
    noticebar.appendChild(nascondi);

    return notice;
}

function ricercaElemento(event){
    //Recupero l'input element
    const research=event.currentTarget;
    //console.log(research.value.toLowerCase());
    //Vedo se è un valore diverso da ''
    if(research.value){
        //Essendoci qualcosa, filtriamo la sezione notizie
        const general=document.querySelector("div.general");
        //Seleziono tutti i titoli
        const titoli=general.querySelectorAll("strong.title");
        //Vedo se il titolo contiene il testo cercato
        for(const t of titoli){
            if(!t.textContent.includes(research.value.toLowerCase())){
                //console.log(t.textContent.includes(research.value));
                //Non lo contiene, lo nascondo
                t.parentNode.parentNode.parentNode.classList.add("hidden");
            }
            //Lo contiene, mi assicuro sia mostrato
            else
            {
                t.parentNode.parentNode.parentNode.classList.remove("hidden");
            }
        }
    }
    //Se non è stato inserito nulla, rimuovo tutti i filtri
    else
    {
        //Seleziono tutte le notizie
        const notice=document.querySelectorAll("div.general div.notice");
        //Per ogni notizia...
        for(const el of notice){
            //...rimuovo la classe hidden
            el.classList.remove("hidden");
        }
    }
}

function onResponse(response){
    return response.json();
}

function onJson(json){
    //Inizializzo i contenuti della pagina dal content.js
    primoCaricamento(json);
    //Assegno a dettagli gli handler per la visione del testo
    const dettagli=document.querySelectorAll(".dettagli");
    for(const det of dettagli){
        det.addEventListener("click", mostraDettagli);
    }
    //Seleziono le icone dei preferiti nella sezione generale delle notizie
    const favourite=document.querySelectorAll("div.general div.immagine div.fav_icon");
    //Ad ogni icona assegno un handler che reagirà ad un click su di esso
    for(const fav of favourite){
        fav.addEventListener("click", addFavourite);
    }
    //Assegno alla barra di ricerca il suo handler
    const research=document.querySelector("input");
    research.addEventListener("keyup", ricercaElemento);
}

fetch("returncontent.php").then(onResponse).then(onJson);

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




