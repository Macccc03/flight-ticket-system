import QtQuick 2.15
import QtQuick.Controls 2.15
import FluentUI 1.0
import QtQuick.Layouts

FluWindow {
    id: mainWindow
    width: Screen.width * 0.6
    height: Screen.height * 0.6
    minimumWidth: 800
    minimumHeight: 600
    visible: true
    title: qsTr("航班票务系统")

    stayTop: false
    showDark: true
    showStayTop: true


    effect: "gaussian-blur"  // 背景高斯模糊效果（类似亚克力）
    tintOpacity: 0.8  // 色调透明度
    blurRadius: 60  // 模糊半径（值越大越模糊）

    Component.onCompleted: {
        FluTheme.darkMode = FluThemeType.Dark  // 默认深色模式
        FluTheme.accentColor = FluColors.Blue  // 强调色为蓝色
        FluTheme.animationEnabled = true  // 启用动画
        FluTheme.nativeText = true  // 使用系统原生字体渲染
        FluTheme.blurBehindWindowEnabled = true  // 启用窗口背后模糊（强化亚克力效果）
    }



    // 用户端布局（FluPaneItem + FluPaneItemExpander 实现）
    FluNavigationView {
        id: userNavView
        anchors.fill: parent
        pageMode: FluNavigationViewType.NoStack
        displayMode: FluNavigationViewType.Auto
        visible: true

        // 简化跳转函数
        function navigateTo(url) {
            userNavView.push(url);
        }

        // 主菜单分组（核心功能）
        items: FluPaneItemExpander {
            title: qsTr("主菜单")
            iconVisible: false
            showEdit: true // 允许用户编辑分组


            FluPaneItem {
                id: item_home
                title: qsTr("首页")
                icon: FluentIcons.Home
                url: "qrc:/qt/Flight_Management_System_Client/views/HomeView.qml"
                onTap: { userNavView.navigateTo(url); }
            }

            FluPaneItem {
                id: item_find
                title: qsTr("发现")
                icon: FluentIcons.QuickNote
                url: "qrc:/qt/Flight_Management_System_Client/views/FindView.qml"
                onTap: { userNavView.navigateTo(url); }
            }

            FluPaneItem {
                id: item_flight_info
                title: qsTr("全部航班")
                icon: FluentIcons.Airplane
                url: "qrc:/qt/Flight_Management_System_Client/views/FlightInfoView.qml"
                onTap: { userNavView.navigateTo(url); }

                iconDelegate: Component {
                    Item {
                        width:15
                        height:15
                        FluIcon {
                            id: planeIcon
                            iconSource: FluentIcons.Airplane
                            iconSize:15
                            y: item_flight_info.hovered ? -3 : 0
                            rotation: item_flight_info.hovered ? 5 : 0
                            Behavior on y { NumberAnimation { duration: 200 } }
                            Behavior on rotation { NumberAnimation { duration: 200 } }
                        }
                        // 绑定 FluPaneItem 的 hovered 状态（关键！）
                        /*
                        MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        planeIcon.y = -3;
                                        planeIcon.rotation = 5;
                                    }
                                    onExited: {
                                        planeIcon.y = 0;
                                        planeIcon.rotation = 0;
                                    }
                                }*/
                    }
                }
            }

            FluPaneItem {
                id: item_flight_favorite
                title: qsTr("我的收藏")
                icon: FluentIcons.FavoriteStar
                url: "qrc:/qt/Flight_Management_System_Client/views/FlightFavoriteView.qml"
                onTap: { userNavView.navigateTo(url); }
            }

            FluPaneItem {
                id: item_orders
                title: qsTr("我的订单")
                icon: FluentIcons.ShoppingCart
                url: "qrc:/qt/Flight_Management_System_Client/views/OrdersView.qml"
                onTap: { userNavView.navigateTo(url); }
            }

            FluPaneItem {
                id: item_profile
                title: qsTr("个人中心")
                icon: FluentIcons.EaseOfAccess
                url: "qrc:/qt/Flight_Management_System_Client/views/ProfileView.qml"
                onTap: { userNavView.navigateTo(url); }
            }
        }

        // 辅助功能分组（底部次要功能）
        footerItems: FluPaneItemExpander {
            title: qsTr("辅助功能")
            iconVisible: false

            FluPaneItem {
                id: item_about
                title: qsTr("关于我们")
                icon: FluentIcons.Info
                url: "qrc:/qt/Flight_Management_System_Client/views/AboutView.qml"
                onTap: { userNavView.navigateTo(url); }


            }

            FluPaneItem {
                id: item_client_server
                title: qsTr("客服")
                icon: FluentIcons.Message
                url: "qrc:/qt/Flight_Management_System_Client/views/ClientServerView.qml"
                onTap: { userNavView.navigateTo(url); }


            }
        }
    }
}
