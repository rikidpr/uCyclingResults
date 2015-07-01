
WorkerScript.onMessage = function(sentMessage) {
    var xmlHttp = new XMLHttpRequest();
    var competitions;
    //segun lo que llegue en el mensaje de fecha, genero, clase... una url u otra, de momento a piñon pa pruebas
    //sentMessage.genderID, setnMessage.classID...
    var baseUrl = "http://10.0.2.2:8282/rest/competitions/query/";
    var url = baseUrl+sentMessage.initDate+","+sentMessage.finishDate+","+
            sentMessage.genderID+","+sentMessage.classID+","+sentMessage.classificationType;
    console.log(url);
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
    console.log("nos disponemos a leer el json");
    xmlHttp.onreadystatechange = function() {
        console.log(xmlHttp.readyState+"/"+xmlHttp.status);
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
    /*
	var msg = '[{"name":"Tour de France (in progress)","id":1282,"category":null,"winner":null,"eventID":12146,"initDate":1435960800000,"finishDate":1437861600000,"editionID":999181,"genderID":1,"classID":1,"phase1ID":-1,"phase2ID":null,"phase3ID":null,"pageID":null,"sportID":102,"seasonID":488,"leader":null,"competitionClass":"UWT","phaseClassificationID":null,"eventPhaseID":999182,"nationality":"FRA","classificationName":null,"competitionType":"STAGE_EVENT","competitionID":20433},{"name":"Dwars door de Vlaamse Ardennen","id":1283,"category":null,"winner":null,"eventID":10635,"initDate":1437256800000,"finishDate":1437256800000,"editionID":1002783,"genderID":1,"classID":1,"phase1ID":-1,"phase2ID":null,"phase3ID":null,"pageID":null,"sportID":102,"seasonID":488,"leader":null,"competitionClass":"C12","phaseClassificationID":null,"eventPhaseID":1003239,"nationality":"BEL","classificationName":null,"competitionType":"ONE_DAY_EVENT","competitionID":27200},{"name":"Trofeo Matteotti","id":1284,"category":null,"winner":null,"eventID":10635,"initDate":1437256800000,"finishDate":1437256800000,"editionID":1002356,"genderID":1,"classID":1,"phase1ID":-1,"phase2ID":null,"phase3ID":null,"pageID":null,"sportID":102,"seasonID":488,"leader":null,"competitionClass":"C11","phaseClassificationID":null,"eventPhaseID":1002858,"nationality":"ITA","classificationName":null,"competitionType":"ONE_DAY_EVENT","competitionID":20643},{"name":"Tour of Qinghai Lake","id":1285,"category":null,"winner":null,"eventID":12146,"initDate":1436047200000,"finishDate":1437170400000,"editionID":1002538,"genderID":1,"classID":1,"phase1ID":-1,"phase2ID":null,"phase3ID":null,"pageID":null,"sportID":102,"seasonID":488,"leader":null,"competitionClass":"HC2","phaseClassificationID":null,"eventPhaseID":1003009,"nationality":"CHN","classificationName":null,"competitionType":"STAGE_EVENT","competitionID":23217}]';
	var competitions = JSON.parse(msg);
	 if (typeof competitions != "undefined") {
		console.log("devolvemos la llamada");
		WorkerScript.sendMessage({'competitions': competitions});
    }*/
}


function formatDate(timestamp){
    var date = new Date(timestamp);
    var mes = date.getMonth()+1;
    var dateFormatted = date.getDate()+"/"+mes+"/"+date.getFullYear()
    return dateFormatted;
}

function getCompetitionTypeName(competitionType){
    switch(competitionType){
    case "ONE_DAY": return "One day comp.";
    case "STAGES": return "Stages comp.";
    default: return competitionType;
    }
}

