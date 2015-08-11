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
import io.thp.pyotherside 1.3
import "pages"
import "components"
import "cook"
import "ui"
import "js/ApiMain.js" as Main
ApplicationWindow
{

    id:applicationWindow
    property var notification;
    property int openimg:-1
    property Page currentPage: pageStack.currentPage
    property string currentclass: "yiliaozhongxin"
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    SignalCenter{
        id: signalCenter;
    }
    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalcenter.loadFailed("erro");
    }


    Component.onCompleted: {
        notification = Qt.createQmlObject("import org.nemomobile.notifications 1.0; Notification{}", applicationWindow)
        Main.setsignalcenter(signalCenter);
    }

    function showMsg(message) {
        notification.previewBody = "医药吧";
        notification.previewSummary = message;
        notification.publish();
    }
    ///////////// 登陆页面
    function toLoginPage() {
        popAttachedPages();
        //pageStack.replace(loginPageComponent);
    }

    function toIndexPage() {
        popAttachedPages();
        pageStack.replace(indexPageComponent)
    }

    function showBusyIndicator() {
        busyIndicator.runningBusyIndicator = true
    }
    function stopBusyIndicator() {
        busyIndicator.runningBusyIndicator = false
    }
    function popAttachedPages() {
        // find the first page
        var firstPage = pageStack.previousPage();
        if (!firstPage) {
            return;
        }
        while (pageStack.previousPage(firstPage)) {
            firstPage = pageStack.previousPage(firstPage);
        }
        // pop to first page
        pageStack.pop(firstPage);
    }

    function tocookPage(){
        pageStack.push(Qt.resolvedUrl("cook/cooklist.qml"))
    }

    initialPage: Component {

        Page{
            Timer {
                id: timerDisplay
                running: true; repeat: false; triggeredOnStart: true
                interval: 1 * 1000
                onTriggered: {
                    toIndexPage();
                }
            }

        }

    }
        //主页列表显示
    Component {
        id: indexPageComponent
        FirstPage {
            id: indexPage
            //            property bool _settingsInitialized: false
            property bool _dataInitialized: false
            property bool withPanelView: true
            Binding {
                target: indexPage.contentItem
                property: "parent"
                value: indexPage.status === PageStatus.Active
                       ? (panelView .closed ? panelView : indexPage) //修正listview焦点
                       : indexPage
            }
            //            Component.onCompleted: {
            //                if (!_settingsInitialized) {
            //                    Settings.initialize();
            //                    _settingsInitialized = true;
            //                }
            //            }
            onStatusChanged: {
                if (indexPage.status === PageStatus.Active) {
                    //                    if (!tokenValid) {
                    //                        startLogin();
                    //                    } else {
                    if (!_dataInitialized) {
                        indexPage.refresh();
                        _dataInitialized = true;
                        //                        }
                    }
                }
            }
        }
    }
BusyIndicator {
    id:busyIndicator
    property bool runningBusyIndicator: false

    parent: applicationWindow.currentPage
    anchors.centerIn: parent
    z: 10
    size: BusyIndicatorSize.Large
    running: runningBusyIndicator
    opacity: busyIndicator.running ? 1: 0
}
PanelView {
    id: panelView
    // a workaround to avoid TextAutoScroller picking up PanelView as an "outer"
    // flickable and doing undesired contentX adjustments (the right side panel
    // slides partially in) meanwhile typing/scrolling long TextEntry content
    property bool maximumFlickVelocity: false

    width: pageStack.currentPage.width
    panelWidth: Screen.width / 3 * 2
    panelHeight: pageStack.currentPage.height
    height: currentPage && currentPage.contentHeight || pageStack.currentPage.height
    visible:  (!!currentPage && !!currentPage.withPanelView) || !panelView.closed
    anchors.centerIn: parent
    //anchors.verticalCenterOffset:  -(panelHeight - height) / 2

    anchors.horizontalCenterOffset:  0

    Connections {
        target: pageStack
        onCurrentPageChanged: panelView.hidePanel()
    }

    function initUserAvatar() {
        leftPanel.initUserAvatar();
    }

    leftPanel: NavigationPanel {
        id: leftPanel
        busy: false //panelView.closed /*&& !!BufferModel.connections && BufferModel.connections.some(function (c) { return c.active && !c.connected })*/
        //            highlighted: MessageStorage.activeHighlights > 0
        onClicked: {
            panelView.hidePanel();
        }

        Component.onCompleted: {
            panelView.hidePanel();
        }
    }
}

Python{
        id:py
        Component.onCompleted: { // this action is triggered when the loading of this component is finished
            addImportPath(Qt.resolvedUrl('./py')); // adds import path to the directory of the Python script
            py.importModule('main', function () { // imports the Python module
            });
        }

        //注册保存方法
        function saveImg(basename,volname){
            console.log("img:"+volname+",basename:"+basename);
            call('main.saveImg',[basename,volname],function(result){
                return result
            })
        }
        //注册缓存方法
        function cacheImg(url,md5name){
            call('main.cacheImg',[url,md5name],function(result){
                //homepageImg = result;
                console.log("local path:"+result)
            })
            //return "image://theme/icon-m-refresh"
        }
        function clearCache(){
            call('main.clearImg',[],function(result){
                   return result
            })
        }

        //onError: signalCenter.showMessage(traceback)
        onReceived: {
            console.log('Event: ' + data);
            var sendMsg="";
            switch(data.toString()){
            case "1":
                sendMsg=qsTr("Successed saved to ~/Pictures/save/Yiyao/")
                break;
            case "-1":
                sendMsg=qsTr("Error")
                break;
            case "2":
                sendMsg=qsTr("Cleared")
                break;
            default:
                sendMsg=qsTr("Unknown")
            }

            signalCenter.showMessage(sendMsg)
        }
    }

    }


