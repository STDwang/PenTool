#include "pentoolsever.h"
#include <QProcess>

void PenToolSever::addRedegit()
{
    QProcess p;
    QString cmd = "wmic cpu get processorid";
    p.start(cmd);
    p.waitForFinished();
    QString cpu = QString::fromLocal8Bit(p.readAllStandardOutput());
    QStringList cpulist = cmd.split(" ");
    cpu = cpu.remove(cpulist.last(), Qt::CaseInsensitive);
    cpu = cpu.replace("\r", "");
    cpu = cpu.replace("\n", "");
    cpu = cpu.simplified();

    cmd = "wmic baseboard get serialnumber";
    p.start(cmd);
    p.waitForFinished();
    QString baseboard = QString::fromLocal8Bit(p.readAllStandardOutput());
    QStringList baseboardlist = cmd.split(" ");
    baseboard = baseboard.remove(baseboardlist.last(), Qt::CaseInsensitive);
    baseboard = baseboard.replace("\r", "");
    baseboard = baseboard.replace("\n", "");
    baseboard = baseboard.simplified();

    computerId = cpu + baseboard;

    QDateTime timeNow = QDateTime::currentDateTime();
    QSettings reg("HKEY_CURRENT_USER\\Software\\IQCreator", QSettings::NativeFormat);
    reg.setValue("DisplayName", "IQCreator");
    reg.setValue("DisplayVersion", "3.0.0");
    reg.setValue("Publisher", "WANGSHUAIPENG");
    if (!reg.contains("InstallTime")) {
        reg.setValue("InstallTime", timeNow);
    }
}

PenToolSever::PenToolSever(QObject *parent) : QObject(parent)
{
    addRedegit();
    softWareMap = readPro();
    qDebug() << "the ThreadId of Main:" << QThread::currentThreadId();
    //对线程池设置最大线程数
    workPool.setMaxThreadCount(4);

    sqlThread = new QThread;
    penToolSql = new PenToolSql();
    penToolSql->moveToThread(sqlThread);

	connect(this, SIGNAL(mysqlLoginTo(QVariantMap)),    penToolSql, SLOT(mysqlLogin(QVariantMap)),    Qt::BlockingQueuedConnection);
	connect(this, SIGNAL(sqliteLoginTo()),              penToolSql, SLOT(sqliteLogin()),              Qt::BlockingQueuedConnection);
    
    connect(this, SIGNAL(addSateTo(QVariantMap)),        penToolSql, SLOT(addSate(QVariantMap)));
    connect(this, SIGNAL(addMbTo(QVariantMap)),          penToolSql, SLOT(addMb(QVariantMap)));
    connect(this, SIGNAL(addProjectTo(QVariantMap)),     penToolSql, SLOT(addProject(QVariantMap)));
    connect(this, SIGNAL(createProjectTo(QVariantMap)),  penToolSql, SLOT(createProject(QVariantMap)));

    connect(this, SIGNAL(editSateTo(QVariantMap)),       penToolSql, SLOT(editSate(QVariantMap)));
    connect(this, SIGNAL(editMbTo(QVariantMap)),         penToolSql, SLOT(editMb(QVariantMap)));
    connect(this, SIGNAL(editProjectTo(QVariantMap)),    penToolSql, SLOT(editProject(QVariantMap)));

    connect(this, SIGNAL(deleteSateTo(QVariantMap)),     penToolSql, SLOT(deleteSate(QVariantMap)));
    connect(this, SIGNAL(deleteMbTo(QVariantMap)),       penToolSql, SLOT(deleteMb(QVariantMap)));
    connect(this, SIGNAL(deleteProjectTo(QVariantMap)),  penToolSql, SLOT(deleteProject(QVariantMap)));

    connect(this, SIGNAL(getSateByIdTo(QVariantMap)),    penToolSql, SLOT(getSateById(QVariantMap)));
    connect(this, SIGNAL(getMbByIdTo(QVariantMap)),      penToolSql, SLOT(getMbById(QVariantMap)));
    connect(this, SIGNAL(getProjectByIdTo(QVariantMap)), penToolSql, SLOT(getProjectById(QVariantMap)));

    connect(this, SIGNAL(getSateListTo()),               penToolSql, SLOT(getSateList()));
    connect(this, SIGNAL(getMbListTo()),                 penToolSql, SLOT(getMbList()));
    connect(this, SIGNAL(getProjectListTo()),            penToolSql, SLOT(getProjectList()));

    connect(penToolSql, SIGNAL(sendOutTip(QVariantMap)),       this, SLOT(receiveOutTip(QVariantMap)));

    connect(penToolSql, SIGNAL(sendSateList(QVariantList)),    this, SLOT(receiveSateList(QVariantList)));
    connect(penToolSql, SIGNAL(sendMbList(QVariantList)),      this, SLOT(receiveMbList(QVariantList)));
    connect(penToolSql, SIGNAL(sendProjectList(QVariantList)), this, SLOT(receiveProjectList(QVariantList)));

    connect(penToolSql, SIGNAL(sendSate(QVariantMap)),         this, SLOT(receiveSate(QVariantMap)));
    connect(penToolSql, SIGNAL(sendMb(QVariantMap)),           this, SLOT(receiveMb(QVariantMap)));
    connect(penToolSql, SIGNAL(sendProject(QVariantMap)),      this, SLOT(receiveProject(QVariantMap)));

    sqlThread->start();
}

PenToolSever::~PenToolSever() {
    sqlThread->quit();
    sqlThread->wait();
    delete penToolSql;

    workPool.waitForDone();
}