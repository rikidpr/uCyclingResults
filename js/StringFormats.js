//////////////////////////////////////
/// UCyclingResults String formats ///
//////////////////////////////////////

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

