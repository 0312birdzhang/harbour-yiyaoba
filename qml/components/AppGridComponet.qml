import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaGridView {
    id: gridView
    clip: true
    height: childrenRect.height
    width: childrenRect.width
    currentIndex: -1
    cellWidth: gridView.width / 3
    cellHeight: cellWidth
    pressDelay: 120;
    cacheBuffer: 2000;
    delegate: BackgroundItem {
        id: rectangle
        width: gridView.cellWidth
        height: gridView.cellHeight
        Label{
            id: moreAppname
            x: morepic.width/2
            text:appname
            width:rectangle.width-Theme.paddingMedium
            truncationMode: TruncationMode.Elide
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            font {
                pixelSize: Theme.fontSizeSmall
                family: Theme.fontFamilyHeading
            }
        }
        Label{
            id:moreimgid
            height: parent.width/2
            width:moreimgid.height
            anchors{
                left:parent.left
                right:parent.right
                top:ratingbox.bottom
                margins: Theme.paddingMedium
            }
            CacheImage{
                id:morepic
                //anchors.fill: parent
                asynchronous: true
                cacheurl: icon
                fillMode: Image.PreserveAspectFit;
                width: parent.height
                height:parent.height

            }
        }
        onClicked :{
            pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{
                                  "appid":appid,
                                  "author":author,
                                  "icon":icon,
                                  "appname":appname
                              })
        }

    }

    //VerticalScrollDecorator {}

}

