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
    property var sexid
    property string classname
    property string sextitle

    id: sexdetailpage
    Component.onCompleted: {
        Main.sexdetailmodel = sexdetailmodel;
        Main.getsexdetail("show?id="+sexid);

    }

    ListModel{id:sexdetailmodel}


    SilicaListView {
            id:view
            anchors.fill: parent
            header: PageHeader {
                id:header
                title:sextitle
                _titleItem.font.pixelSize: Theme.fontSizeSmall
            }
            currentIndex: -1
            model : sexdetailmodel
            spacing: Theme.paddingMedium
            clip: true
            delegate:ListItem{
                height:imgID.height + Theme.paddingMedium*2
                width:parent.width
                CacheImage{
                    id:imgID
                    fillMode: Image.Stretch;
                    width:  parent.width
                    height: parent.width
                    opencache: src?true:false
                    cacheurl:"http://tnfs.tngou.net/image"+src
                    anchors {
                        top:parent.top
                        right: parent.right
                        margins: Theme.paddingMedium
                    }
                   MouseArea{
                       anchors.fill: parent
                       onClicked:{
                           pageStack.push(Qt.resolvedUrl("../components/ImagePage.qml"),
                                          {"localUrl":imgID.source,
                                              "imgname":"meizi_"+id,
                                              "remoteUrl":"http://tnfs.tngou.net/image"+src
                                          });
                       }
                   }

                }
            }


            VerticalScrollDecorator {}


    }
    BusyIndicator{
        running: !PageStatus.Active
        size:BusyIndicatorSize.Large
        anchors.fill: parent
    }

}




