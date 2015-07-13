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

Page {
    id: askpage
    property int pagenum:1
    property var askcateid
    property bool showsearch: false
    Component.onCompleted: {
        Main.listmodel = asklistmodel;
        getlist()

    }
    onShowsearchChanged: {
        if (showsearch) {
            searchfield.forceActiveFocus()
        }else{

            askpage.focus=true
        }
    }

    function getlist(){
        if(askcateid){
            Main.getlist("ask/list?page="+pagenum+"&id="+askcateid);
        }else{
            Main.getlist("ask/list?page="+pagenum);
        }
    }

    onStatusChanged: {
        if (status == PageStatus.Active) {
            if (pageStack._currentContainer.attachedContainer == null) {
                pageStack.pushAttached(Qt.resolvedUrl("askcategory.qml"))
            }
        }
    }
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: asklistmodel.count == 0|!PageStatus.Active
        size: BusyIndicatorSize.Large
    }
    ListModel{id:asklistmodel}

    Column {
        id: headerContainer

        width: askpage.width

        PageHeader {
            id:header
            title: qsTr("AskList")
        }
        SearchField {
            id: searchfield
            visible: showsearch
            width: parent.width
            y:showsearch?(header.y + Theme.paddingMedium):0
            Binding {
                target: askpage
                property: "searchString"
                value: searchfield.text
            }
            EnterKey.onClicked: {
                askcateid = undefined;
                asklistmodel.clear();
                Main.getlist("ask/search?keyword="+searchfield.text);
                parent.focus=true
            }
        }
    }



    SilicaListView {
            id: listView
            model: asklistmodel
            currentIndex: -1
            anchors.fill: parent


            spacing:Theme.paddingMedium
            PullDownMenu{
                MenuItem{
                    id:pulldown
                    text:showsearch?qsTr("Hide Search"):qsTr("Show Search")
                    onClicked: {
                        showsearch?(showsearch=false):(showsearch=true)
                    }
                }
            }
            header:PageHeader{
                id:listHeader
                width:headerContainer.width
                height: headerContainer.height
                Component.onCompleted:headerContainer.parent = listHeader
            }

            delegate: BackgroundItem{
                    id:showlist
                    height: asktit.height +Theme.paddingMedium*2

                    Text {
                        id:asktit
                        wrapMode: Text.WordWrap
                        width: parent.width
                        font.bold:true;
                        text:title
                        color:Theme.highlightColor
                        anchors{
                            top:parent.top
                            right:tag.left
                            left: parent.left
                            margins: Theme.paddingMedium
                        }

                    }
                    Label{
                        id:tag

                        anchors{
                            top:parent.top
                            right:parent.right
                            margins: Theme.paddingSmall
                        }
                        text:classname?"["+classname+"]":""
                        opacity:0.9
                        font.pixelSize:Theme.fontSizeExtraSmall
                    }

                onClicked: {
                    pageStack.push(Qt.resolvedUrl("askdetail.qml"),
                                   {
                                       "askid":id,
                                       "classname":classname,
                                       "asktitle":title
                                   })
                }
            }
            VerticalScrollDecorator {}
            footer: Component{
                Item {
                    id: footerComponent
                    visible: !busyIndicator.running
                    anchors { left: parent.left; right: parent.right;topMargin: Theme.paddingMedium }
                    height:  Theme.itemSizeMedium
                    signal clicked()
                    Row {
                        id:footItem
                        spacing: Theme.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            text: "上一页"
                            visible: pagenum>1
                            onClicked: {
                                pagenum--;
                                asklistmodel.clear();
                                getlist();
                            }
                        }
                        Button {

                            text: "下一页"
                            onClicked: {
                                pagenum = pagenum+1;
                                asklistmodel.clear();
                                getlist();
                            }
                        }

                    }
                }

            }


        }

}





