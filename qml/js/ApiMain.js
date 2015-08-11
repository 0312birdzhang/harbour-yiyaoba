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
    sendWebRequest(url,loadlist,"POST","");
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

//分类
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

//健康一问
var askdetailmodel;
function getanswer(type){
    var url=apiurl+type;
    sendWebRequest(url,loadanswer,"GET","");
}
function loadanswer(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success == "true"){
        askdetailmodel.clear();
    }
    for(var i in obj.yi18.answer){
        askdetailmodel.append(obj.yi18.answer[i]);
    }
}

//美女图片,单独api
var sexapi = "http://www.tngou.net/tnfs/api/"

var sexlistmodel;
function getsexlist(type){
    var url=sexapi+type;
    sendWebRequest(url,loadsexlist,"POST","");
}
function loadsexlist(oritxt){
    var obj=JSON.parse(oritxt);

    for(var i in obj.tngou){
        sexlistmodel.append(obj.tngou[i]);
    }
    signalcenter.loadFinished();
}

var sexdetailmodel;
function getsexdetail(type){
    var url=sexapi+type;
    sendWebRequest(url,loadsexdetail,"GET","");
}
function loadsexdetail(oritxt){
    var obj=JSON.parse(oritxt);

    sexdetailmodel.clear()

    for(var i in obj.list){
        sexdetailmodel.append(obj.list[i]);
    }
    signalcenter.loadFinished();
}

//分类
var sexcatemodel;
var sexcate = [
                {"description":"……","id":1,"keywords":"……","name":"性感美女","seq":1,"title":"……"},
                {"description":"……","id":2,"keywords":"……","name":"韩日美女","seq":2,"title":"……"},
                {"description":"……","id":3,"keywords":"……","name":"丝袜美腿","seq":3,"title":"……"},
                {"description":"……","id":4,"keywords":"……","name":"美女照片","seq":4,"title":"……"},
                {"description":"……","id":5,"keywords":"……","name":"美女写真","seq":5,"title":"……"},
                {"description":"……","id":6,"keywords":"……","name":"清纯美女","seq":6,"title":"……"},
                {"description":"……","id":2,"keywords":"……","name":"性感车模","seq":7,"title":"……"}
            ];

function getsexcate(){
    for(var i in sexcate){
        sexcatemodel.append(sexcate[i]);
    }
}
