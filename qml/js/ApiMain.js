.pragma library
Qt.include("ApiCore.js")
var signalcenter;
function setsignalcenter(mycenter){
    signalcenter=mycenter;
}
function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        switch(xmlhttp.readyState) {
        case xmlhttp.OPENED:signalcenter.loadStarted();break;
        case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("connect error,code:")+xmlhttp.status+"  "+xmlhttp.statusText);break;
        case xmlhttp.DONE:if (xmlhttp.status == 200) {
                try {
                    callback(xmlhttp.responseText);
                    signalcenter.loadFinished();
                } catch(e) {
                    signalcenter.loadFailed(qsTr("loading erro..."));
                }
            } else {
                signalcenter.loadFailed("");
            }
            break;
        }
    }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

var listmodel;
function getlist(type){
    var url=apiurl+type;
    sendWebRequest(url,loadlist,"GET","");
}
function loadlist(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success == "true"){
        listmodel.clear();
    }
    for(var i in obj.yi18){
        listmodel.append(obj.yi18[i]);
    }
    signalcenter.loadFinished();
}


var detailmodel;
function getdetail(type){
    var url=apiurl+type;
    sendWebRequest(url,loaddetail,"GET","");
}
function loaddetail(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success){
        detailmodel.clear()
        detailmodel.append(obj.yi18)
    }
    signalcenter.loadFinished();
}

var showmodel;
function getshow(type){
    var url=apiurl+type;
    sendWebRequest(url,loadshow,"GET","");
}
function loadshow(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success ==="true"){
        showmodel.clear();
    }
    for(var i in obj.yi18){
        showmodel.append(obj.yi18[i]);
    }
}

var cookmessage;
var cooktag;
function getcookdetail(cookid){
         var url =apiurl+"/cook/show?id="+cookid;
         sendWebRequest(url,loadcookdetail,"GET","");
    }
function loadcookdetail(oritxt){
         var obj=JSON.parse(oritxt);
         cookmessage=obj.yi18.message;
         cooktag = obj.yi18.tag;
         signalcenter.loadFinished();
        }
var catemodel;
function getcate(type){
    var url=apiurl+type;
    sendWebRequest(url,loadcate,"GET","");
}
function loadcate(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success == "true"){
        catemodel.clear();
    }
    for(var i in obj.yi18){
        catemodel.append(obj.yi18[i]);
    }
}


