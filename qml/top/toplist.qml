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
import "../components"
import "../js/ApiMain.js" as Main
Page{
    id:topPage
    property int pagenum:1

    Component.onCompleted: {
        Main.listmodel = listModel;
        getnews();

    }
    function getnews(){
         Main.getlist("top/list?page="+pagenum);
    }

    ListModel {  id:listModel }
    SilicaListView {
        id:view
        header:PageHeader {
            id:header
            title:qsTr("topnews")
        }
        PullDownMenu {
            id:pulldownid
            MenuItem {
                text:qsTr("refresh")
                onClicked:  getnews();
            }
        }

        anchors.fill:parent
        spacing:Theme.paddingMedium
        model : listModel
        clip: true
        delegate:BackgroundItem{
            id:showlist
            width: parent.width
            height: imgID.height>(titleID.height +dateID.height)?(imgID.height+ Theme.paddingSmall*6):(titleID.height +dateID.height+ Theme.paddingSmall*6)
            Label{
                id:titleID
                text:title
                font.bold:true;
                font.pixelSize: Theme.fontSizeMedium
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
                maximumLineCount: 3
                anchors {
                    top:parent.top
                    left: parent.left
                    right: imgID.left
                    margins: Theme.paddingSmall
                }
            }
            CacheImage{
                id:imgID
                fillMode: Image.Stretch;
                width:  Screen.width/3
                height: Screen.width/3
                cacheurl:"http://www.yi18.net/"+img
                anchors {
                    right: parent.right
                    margins: Theme.paddingSmall
                }
            }

            Label{
                id:dateID
                text:qsTr("datetime:")+Format.formatDate(time, Formatter.TimepointRelative)
                font.pixelSize: Theme.fontSizeSmall
                font.italic: true
                horizontalAlignment: Text.AlignRight
                anchors {
                    left: fromID.right
                    bottom:parent.bottom
                    margins: Theme.paddingSmall
                }
            }
            Label{
                id:views
                text:qsTr("views count:")+count
                font.pixelSize: Theme.fontSizeExtraSmall
                font.italic: true
                horizontalAlignment: Text.AlignRight
                anchors {
                    right: parent.right
                    bottom:parent.bottom
                    margins: Theme.paddingSmall
                }
            }
            Label{
                id:fromID
                text:qsTr("from: ")+from
                font.pixelSize: Theme.fontSizeExtraSmall
                font.italic: true
                horizontalAlignment: Text.AlignRight
                anchors {
                    left: parent.left
                    bottom:parent.bottom
                    margins: Theme.paddingSmall
                }
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl("topdetail.qml"),{
                                   "id":id
                               })
            }
        }


        VerticalScrollDecorator {}
        footer: Component{

            Item {
                id: footerComponent
                anchors { left: parent.left; right: parent.right }
                height: visible ? Theme.itemSizeMedium : 0
                visible:listModel.count > 4
                signal clicked()
                Item {
                    id:footItem
                    width: parent.width
                    height: Theme.itemSizeMedium
                    Button {
                        anchors.centerIn: parent
                        text: "加载更多..."
                        onClicked: {
                            pagenum++;
                            getnews();
                        }
                    }
                }
            }

        }
    }


    BusyIndicator{
        running: !PageStatus.Active
        size:BusyIndicatorSize.Large
        anchors.fill: parent
    }

}
