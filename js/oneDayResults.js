//"results/oneDay/"
WorkerScript.onMessage = function(sentMessage) {
    var xmlHttp = new XMLHttpRequest();
    var results;
    var baseUrl = "http://localhost:8282/rest/results/oneDay/";
    var url = baseUrl+sentMessage.competitionID+","+sentMessage.eventID+","+
            sentMessage.editionID+","+sentMessage.genderID+","+sentMessage.classID;

    console.log("url que llamaremos:"+url);
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            var msg = xmlHttp.responseText;
            console.log("json leido:"+msg);
            results = JSON.parse(msg);
            if (typeof results != "undefined") {
                WorkerScript.sendMessage({'results': results});
            }
        }
    }
}
