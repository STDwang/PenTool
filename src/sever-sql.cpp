#include "pentoolsever.h"
/*
	·¢ÐÅºÅ¸øsql
*/
bool PenToolSever::mysqlLogin(QVariantMap data)
{
	return emit mysqlLoginTo(data);
}

bool PenToolSever::sqliteLogin()
{
	return emit sqliteLoginTo();
}

void PenToolSever::addSate(QVariantMap data)
{
	emit addSateTo(data);
}

void PenToolSever::addMb(QVariantMap data)
{
	emit addMbTo(data);
}

void PenToolSever::addProject(QVariantMap data)
{
	emit addProjectTo(data);
}

void PenToolSever::deleteSate(QVariantMap data)
{
	emit deleteSateTo(data);
}

void PenToolSever::deleteMb(QVariantMap data)
{
	emit deleteMbTo(data);
}

void PenToolSever::deleteProject(QVariantMap data)
{
	emit deleteProjectTo(data);
}

void PenToolSever::editSate(QVariantMap data)
{
	emit editSateTo(data);
}

void PenToolSever::editMb(QVariantMap data)
{
	emit editMbTo(data);
}

void PenToolSever::editProject(QVariantMap data)
{
	emit editProjectTo(data);
}

void PenToolSever::getSateById(QVariantMap data)
{
	emit getSateByIdTo(data);
}

void PenToolSever::getMbById(QVariantMap data)
{
	emit getMbByIdTo(data);
}

void PenToolSever::getProjectById(QVariantMap data)
{
	emit getProjectByIdTo(data);
}

void PenToolSever::getSateList()
{
	emit getSateListTo();
}

void PenToolSever::getMbList()
{
	emit getMbListTo();
}

void PenToolSever::getProjectList()
{
	emit getProjectListTo();
}