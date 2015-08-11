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
    id:cookdetail
    property var cookmessage:""
    property var cooktag:""
    property var cookid
    property var cookimg
    property var remoteurl
    property var cookname
    Component.onCompleted:{
        Main.getcookdetail(cookid);
    }
    Connections{
        target: signalCenter;
        onLoadFinished:{
            cooktag=Main.cooktag;
            cookmessage = Main.cookmessage;
        }
    }
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
    }

    SilicaFlickable{
        id:fickable
        anchors.fill: parent
        PageHeader{
            id:header
            title:cookname
            _titleItem.font.pixelSize: Theme.fontSizeSmall
        }
        contentHeight: tagname.height + detail.height +cookpic.height + Theme.paddingLarge * 10
        Label{
            id:tagname
            text:qsTr("tags :")+cooktag
            wrapMode: Text.WordWrap
            width:parent.width
            font.pixelSize: Theme.fontSizeTiny
            color: Theme.secondaryColor
            anchors{
                top:header.bottom
                left:parent.left
                right:parent.right
                margins: Theme.paddingLarge
            }
        }

       Label{
           id:detail
           width: parent.width
           wrapMode: Text.WordWrap
           textFormat: Text.RichText
           font.pixelSize:Theme.fontSizeSmall
           font.letterSpacing: Theme.paddingSmall
           anchors{
               top:tagname.bottom
               left:parent.left
               right:parent.right
               margins: Theme.paddingLarge
           }
           text:cookmessage
           color: fickable.highlighted ? Theme.highlightColor : Theme.primaryColor

       }

       Image{
           id:cookpic
           fillMode: Image.Stretch;
           width:  parent.width
           height: parent.width
           source: cookimg
           anchors{
               top:detail.bottom
               left:parent.left
               right:parent.right
               margins: Theme.paddingLarge
           }
//           MouseArea{
//               anchors.fill: parent
//               onClicked:{
//                   pageStack.push(Qt.resolvedUrl("../components/ImagePage.qml"),{"localUrl":cookimg,"imgname":cookname});
//               }
//           }
       }

       Item{
           anchors.top: cookpic.bottom
           width:1;
           height: Theme.paddingLarge*3
       }
    }


}
