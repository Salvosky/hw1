fetch("http://universities.hipolabs.com/search?country=italy")
    .then(onResponse)
    .then(onJson);

function onResponse(response){
    //console.log(response);
    if(response.ok){
        return response.json();
    }
}

function onJson(json){
    //console.log(json);
    for(const uni of json){
        if(uni.name==="University of Catania"){
            //console.log(uni.name);
            //console.log(uni.web_pages);
            document.querySelector("footer a").href=uni.web_pages;
            document.querySelector("footer a").textContent="Università degli studi di Catania";
        }
    }
}