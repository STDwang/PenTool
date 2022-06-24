#include "pentoolwork.h"

void Work::task2(mbClass mb)
{
	QVariantMap progressMap;
	progressMap["progress"] = 10;
	emit sendProgress(progressMap);
}