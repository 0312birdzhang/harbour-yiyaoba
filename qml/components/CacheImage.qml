import QtQuick 2.0
import io.thp.pyotherside 1.3
import "../js/md5.js" as MD5

Image {
    id: root
    property string cacheurl: ""
    asynchronous: true
    Python{
        id:imgpy
         Component.onCompleted: {
         addImportPath(Qt.resolvedUrl('../py')); // adds import path to the directory of the Python script
         imgpy.importModule('main', function () {
             var imglist=cacheurl.split(".")
             var imgtype=imglist[imglist.length-1]
                call('main.cacheImg',[cacheurl,MD5.hex_md5(cacheurl)+"."+imgtype],function(result){
                     root.source = result;
                    waitingIcon.visible = false
                });
       })
      }
         onError: {
             errorIcon.visible = true;
         }

    }
    Image{
        id:waitingIcon
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        source: "image://theme/icon-m-refresh";
        visible: true
    }
    Image{
        id:errorIcon
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        source: "image://theme/icon-status-data-error";
        visible: false;
    }
}
