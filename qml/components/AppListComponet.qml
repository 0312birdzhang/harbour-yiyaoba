import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem{
    id:showlist
    height:appnameid.height+authorname.height+apppic.width/5+Theme.paddingMedium*2
    width: parent.width
    anchors.leftMargin: Theme.paddingSmall
    anchors.rightMargin: Theme.paddingSmall
    CacheImage{
        id:apppic
        asynchronous: true
        cacheurl: icon
        fillMode: Image.PreserveAspectFit;
        width:  Screen.height/12
        height: Screen.height/12
        Image{
            anchors.fill: parent;
            source: "../../img/App_icon_Loading.svg";
            visible: parent.status==Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../img/App_icon_Error.svg";
            visible: parent.status==Image.Error;
        }

        anchors {
            left: parent.left
            top:parent.top
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingMedium
            bottomMargin: Theme.paddingMedium
            verticalCenter:parent.verticalCenter
        }
    }
    Label{
        id:appnameid
        text:appname
        width: parent.width-apppic.width-Theme.paddingSmall
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.highlightColor
        font.bold: true
        //truncationMode: TruncationMode.Fade
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Elide
        anchors {
            top:apppic.top
            left: apppic.right
            leftMargin: Theme.paddingLarge
        }
    }

    Label{
        id:authorname
        x:apppic.width+Theme.paddingSmall
        text:author
        font.pixelSize: Theme.fontSizeExtraSmall * 4 / 3
        horizontalAlignment: Text.AlignLeft
        anchors {
            top:appnameid.bottom
            left: apppic.right
            leftMargin: Theme.paddingLarge
            topMargin: Theme.paddingSmall
        }
    }

    Separator {
        visible: (index>0?true:false)
        width:parent.width;
        color: Theme.highlightColor
    }
    onClicked: {
        pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{
                           "appid":appid,
                           "author":author,
                           "icon":icon,
                           "category":category
                       })
    }
}
