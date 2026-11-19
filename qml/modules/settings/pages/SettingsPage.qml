import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: contentColumn.height

        Column {
            id: contentColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: "Настройки" }

            Label {
                width: parent.width - 2 * Theme.horizontalPageMargin
                x: Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                text: "Здесь появятся настройки приложения."
            }

            Button {
                text: "Мои модели"
                onClicked: pageStack.push(Qt.resolvedUrl("../../models/pages/ModelsPage.qml"))
            }
            Button {
                text: "Каталог"
                onClicked: pageStack.push(Qt.resolvedUrl("../../catalog/pages/CatalogPage.qml"))
            }
            Button {
                text: "Чат"
                onClicked: pageStack.push(Qt.resolvedUrl("../../chat/pages/ChatPage.qml"))
            }
        }
    }
}
