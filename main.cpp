#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QtWebView>
#include <QtWebEngine>
#include "./src/pentoolsever.h"
#include "./src/qmlplot.h"
#include "./src/websockettransport.h"
#include "./src/t2d/Toou2D.h"

int main(int argc, char* argv[])
{
	qputenv("QSG_RENDER_LOOP", "basic");
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
	//QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

	QApplication app(argc, argv);
	QtWebView::initialize();

	app.setApplicationName("PenTool");
	app.setWindowIcon(QIcon(":/res/png/sate(1).png"));

	QQmlApplicationEngine engine;
	qmlRegisterType<PenToolSever>("an.qml.PenToolSever", 1, 0, "PenToolSever");
	qmlRegisterType<CustomPlotItem>("an.qml.PenToolSever", 1, 0, "CustomPlotItem");
	qmlRegisterType<WebSocketTransport>("an.qml.PenToolSever", 1, 0, "WebSocketTransport");
#if defined(STATICLIB)
	Toou2D::create(&engine);
#endif

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
