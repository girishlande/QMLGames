#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
#include "mapper.h"
#include "playersclub.h"
#include "player.h"
#include "piece.h"
#include "piecemodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    PieceModel pieceModel;
    Mapper mapper;
    PlayersClub club(&mapper);
    club.getPlayerPieces(pieceModel);

    qmlRegisterType<Player>("Player",1,0,"Player");
    qmlRegisterType<Piece>("Piece",1,0,"Piece");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("mapper",&mapper);
    engine.rootContext()->setContextProperty("club",&club);
    engine.rootContext()->setContextProperty("pieceModel",&pieceModel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
