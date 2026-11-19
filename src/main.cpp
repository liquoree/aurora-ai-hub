#include <QtQuick>
#include <auroraapp.h>

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.auroraaihub"));
    application->setApplicationName(QStringLiteral("aurora_ai_hub"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/aurora-ai-hub.qml")));
    view->show();

    return application->exec();
}
