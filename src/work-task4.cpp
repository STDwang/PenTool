#include "pentoolwork.h"

void Work::task4()
{
	QVariantMap progressMap;
	progressMap["progress"] = 100;
	emit sendProgress(progressMap);
}