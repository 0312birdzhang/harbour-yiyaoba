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
    property var drugid
    property string drugtitle

    id: detailpage
    Component.onCompleted: {
        Main.detailmodel = drugdetailmodel;
        Main.getdetail("drug/show?id="+drugid);

    }

    ListModel{id:drugdetailmodel}


//    Label{
//        id:classtag
//        //width: parent.width
//        font.pixelSize:Theme.fontSizeExtraSmall
//        wrapMode: Text.WordWrap
//        text:"tag: "+classname
//        anchors{
//            top:header.bottom
//            right:parent.right
//            margins: Theme.paddingMedium
//        }
//    }


    SilicaListView {
            id:view
            anchors.fill: parent
            header: PageHeader {
                id:header
                title:drugtitle
                _titleItem.font.pixelSize: Theme.fontSizeSmall
            }
            currentIndex: -1
            model : drugdetailmodel
            clip: true
            delegate:Item{
                height:childrenRect.height + Theme.paddingMedium *4
                width:parent.width
                Label{
                    id:infoID
                    text:"["+ANumber+"] "+PType
                    wrapMode: Text.WordWrap
                    width: parent.width
                    font.pixelSize:Theme.fontSizeSmall
                    opacity: 0.9
                    anchors{
                        top:parent.top
                        left:parent.left
                        right:parent.right
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:pri
                    text:factory/*+ "<br/> 售价 :"+price*/
                    font.pixelSize:Theme.fontSizeExtraSmall
                    anchors{
                        top:infoID.bottom
                        left:parent.left
                        right:parent.right
                        margins: Theme.paddingMedium
                    }

                }
                Label{
                    id:tagID
                    text:"作用: "+tag
                    width: parent.width
                    font.pixelSize:Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                    anchors{
                        top:pri.bottom
                        left:parent.left
                        right:parent.right
                        margins: Theme.paddingMedium
                    }
                }

                Label {
                    wrapMode: Text.WordWrap
                    width: parent.width
                    textFormat: Text.RichText
                    text: message
                    font.pixelSize:Theme.fontSizeSmall
                    font.letterSpacing: Theme.paddingSmall
                    color: view.highlighted ? Theme.highlightColor : Theme.primaryColor
                    anchors {
                        top:tagID.bottom
                        left: parent.left
                        right:parent.right
                        margins: Theme.paddingMedium

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




