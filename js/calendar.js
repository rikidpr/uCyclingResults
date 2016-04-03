WorkerScript.onMessage = function(sentMessage) {
    var xmlHttp = new XMLHttpRequest();
    var calendar;
    var baseUrl = cyclingResultsHost+"/rest/calendar/query/";
    var url = baseUrl+sentMessage.initDate+","+sentMessage.finishDate+","+sentMessage.name+","+
            sentMessage.country+","+sentMessage.category+","+sentMessage.eventClass;
    console.log(url);
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            var msg = xmlHttp.responseText;
	    calendar = JSON.parse(msg);

            if (typeof caledar != "undefined") {
                WorkerScript.sendMessage({'calendar': calendar});
            }
        }
    }

}



