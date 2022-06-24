#include "pentoolwork.h"

void Work::task3(mbClass mb)
{
	QVariantMap progressMap;
	progressMap["progress"] = 50;
	emit sendProgress(progressMap);
}