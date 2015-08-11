import QtQuick 2.0
import Sailfish.Silica 1.0


import "../components"


Panel {
    id: panel

//    property var _usrInfo: {"id":-1,"idstr":"","class":1,"screen_name":"","name":"","province":"","city":"","location":"","description":"","url":"","cover_image_phone":"","profile_image_url":"","profile_url":"","domain":"","weihao":"","gender":"","followers_count":0,"friends_count":0,"statuses_count":0,"favourites_count":0,"created_at":"Sun Jan 22 13:32:37 +0800 1999","following":false,"allow_all_act_msg":false,"geo_enabled":true,"verified":false,"verified_type":-1,"remark":"","status":{"text": "", "reposts_count": 0, "comments_count": 0, "attitudes_count": 0},"ptype":0,"allow_all_comment":true,"avatar_large":"","avatar_hd":"","verified_reason":"","follow_me":false,"online_status":0,"bi_followers_count":0,"lang":"zh-cn","star":0,"mbtype":0,"mbrank":0,"block_word":0}

    property bool _userAvatarLock: false

    signal clicked
    signal userAvatarClicked

    function initUserAvatar() {

    }

    function reloadIndex(classname){
        currentclass=classname;
        toIndexPage();
    }

    Column {
        id: column
        spacing: Theme.paddingMedium
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Item {
            id: userAvatar
            width: column.width
            height: cover.height
            BusyIndicator {
                id: avatarLoading
                anchors.centerIn: parent
                parent: userAvatar
                size: BusyIndicatorSize.Small
                opacity: avatarLoading.running ? 1 : 0
                running: cover.status != Image.Ready && profile.status != Image.Ready
            }
            Image {
                id: cover
                width: parent.width
                height: cover.width *2/3
                fillMode: Image.PreserveAspectCrop
                opacity: 0.6
                asynchronous: true
                source: "../pics/background.png"
                onStatusChanged: {
                    if (cover.status == Image.Ready) {
                        //util.saveRemoteImage(userInfoObject.usrInfo.cover_image_phone)
                    }
                }
            }
            Image {
                id: profile
                width: userAvatar.width/4
                height: width
                anchors.centerIn: cover
                asynchronous: true
                source: "../pics/victory.png"
                onStatusChanged: {
                    if (profile.status == Image.Ready) {
                        //util.saveRemoteImage(userInfoObject.usrInfo.profile_image_url)
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        userAvatarClicked();
                    }
                }
            }
//            Label {
//                id: screenName
//                text: "test"
//                anchors {
//                    top: profile.bottom
//                    topMargin: Theme.paddingSmall
//                    horizontalCenter: profile.horizontalCenter
//                }
//                font.pixelSize: Theme.fontSizeExtraSmall
//                color: Theme.secondaryColor
//            }
        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("yiliaozhongxin")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/yiliaozhongxin.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    reloadIndex("yiliaozhongxin");
                }
            }
        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: atMeWeibo
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("qiyedaquan")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/qiyedaquan.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    reloadIndex("qiyedaquan");
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: atMeComment
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("wenhuazhishi")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/wenhuazhishi.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    reloadIndex("wenhuazhishi");
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: comment
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("yaopinshipin")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/yaopinshipin.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    reloadIndex("yaopinshipin");
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: pm
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("xinwenzixun")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/xinwenzixun.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    reloadIndex("xinwenzixun");
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: sex
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("meinv")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/sex.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    reloadIndex("meinv");
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("Settings")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/shezhi.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                   pageStack.push(Qt.resolvedUrl("../pages/SettingPage.qml"));
                }
            }
        }
    }
}
