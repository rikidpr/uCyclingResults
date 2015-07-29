Qt.include("Contracts.js")

//example url:http://localhost:8282/rest/competitions/stageRaceCompetitions/20700,12146,810684,1,1
WorkerScript.onMessage = function(sentMessage) {
    var xmlHttp = new XMLHttpRequest();
    var competitions;
    //segun lo que llegue en el mensaje de fecha, genero, clase... una url u otra, de momento a piñon pa pruebas
    //sentMessage.genderID, setnMessage.classID...
    var baseUrl = cyclingResultsHost+"/rest/competitions/stageRaceCompetitions/";
    var url = baseUrl+sentMessage.competitionID+","+sentMessage.eventID+","+sentMessage.editionID
        +","+sentMessage.genderID+","+sentMessage.classID;
    //var url = baseUrl+"20700,12146,810684,1,1";
    console.log("url que llamaremos:"+url);
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            var msg = xmlHttp.responseText;
            console.log("json leido:"+msg);
            competitions = JSON.parse(msg);

            if (typeof competitions != "undefined") {
                console.log("devolvemos la llamada");
                WorkerScript.sendMessage({'competitions': competitions});
            }
        }
    }
}
