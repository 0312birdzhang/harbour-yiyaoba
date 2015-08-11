/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/ApiClass.js" as Class

Page {
    id: page

    property alias contentItem:filick
    function refresh() {

    }

    ListModel{
        id:classmodel
    }
    SilicaFlickable {
        id:filick
        anchors.fill: parent

        contentHeight: header.height + gridView.height

        PageHeader {
            id:header
            title: qsTr("fen lei")
        }


        Component.onCompleted: {
           Class.currentClass(currentclass)

        }

        SilicaGridView {
            id: gridView
            model: classmodel
            anchors{
                top:header.bottom
                left:parent.left
                right:parent.right
                margins: Theme.paddingMedium
            }
            height: childrenRect.height
            width: childrenRect.width
            currentIndex: -1
            cellWidth: gridView.width / 2
            cellHeight: cellWidth
            pressDelay: 120;
            cacheBuffer: 2000;
            delegate: BackgroundItem {
                id: rectangle
                width: gridView.cellWidth
                height: gridView.cellHeight
                GridView.onAdd: AddAnimation {
                    target: rectangle
                }
                GridView.onRemove: RemoveAnimation {
                    target: rectangle
                }

                OpacityRampEffect {
                    sourceItem: secdclassname
                    offset: 0.8
                }
                Label{
                    id: secdclassname
                    width: parent.width - Theme.paddingLarge
                    //color: gridView.highlighted ? Theme.highlightColor : Theme.primaryColor
                    color: Theme.highlightColor
                    font.bold:true;
                    text:name
                    font {
                        pixelSize: Theme.fontSizeSmall
                    }
                    anchors{
                        top:parent.top
                        horizontalCenter: parent.horizontalCenter
                    }

                }
                Image{
                    id:classImg
                    width: parent.width - Theme.paddingLarge * 4
                    height: parent.height - Theme.paddingLarge * 4
                    smooth: true
                    source:"../pics/"+id+".png"
                    fillMode: Image.PreserveAspectFit
                    anchors{
                        top:secdclassname.bottom
                        horizontalCenter: parent.horizontalCenter
                        margins: Theme.paddingLarge
                    }
                }

                onClicked :{
                    console.log("apid:"+apid);
                    switch(apid){
                    case "disease":
                        pageStack.push(Qt.resolvedUrl("../disease/diseaselist.qml"));
                        break;
                    case "cook":
                        pageStack.push(Qt.resolvedUrl("../cook/cooklist.qml"))
                        break;
                    case "top":
                        pageStack.push(Qt.resolvedUrl("../top/toplist.qml"));
                        break;
                    case "ask":
                        pageStack.push(Qt.resolvedUrl("../ask/asklist.qml"));
                        break;
                    case "news":
                        pageStack.push(Qt.resolvedUrl("../news/newslist.qml"));
                        break;
                    case "drug":
                        pageStack.push(Qt.resolvedUrl("../drug/druglist.qml"));
                        break;
                    case "sex":
                        pageStack.push(Qt.resolvedUrl("../sex/sexlist.qml"));
                        break;
                    default:
                        pageStack.push(Qt.resolvedUrl(""));

                    }
                }

            }

            VerticalScrollDecorator {}

        }

    }
}


