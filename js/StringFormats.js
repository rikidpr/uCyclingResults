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

function truncate(cadena, maxLength){
    if (cadena.length <= maxLength){
        return cadena;
    } else {
        return cadena.substring(0,maxLength)+"...";
    }
}

function getOneDayResultsBackgroundColor(index){
    if (index ===0 ){
        return "#DD4814";
    } else if (index === 1){
        return "#E36C43";
    } else if (index === 2){
        return "#EA9172";
    } else {
        return index % 2 == 0 ? "#F8DAD0" : "#FBECE7"
    }
}

function getOneDayResultsForegroundColor(index){
    if (index < 3){
        return "white";
    } else {
        return "black"
    }
}

function getClassificationBackgroundColor(index){
    if (index ===0 ){
        return "#772953";
    } else if (index === 1){
        return "#925375";
    } else if (index === 2){
        return "#AD7E97";
    } else {
        return index % 2 == 0 ? "#E3D4DC" : "#F1E9ED"
    }
}

function getClassificationForegroundColor(index){
    if (index < 3){
        return "white";
    } else {
        return "black"
    }
}

function getListBackgroundColor(index){
    if (index % 2 === 0){
        return "#EADEE5";
    } else {
        return "#F1E9ED";
    }
}

function getPositiveButtonColor(){
    return "#3fb24f";
}
