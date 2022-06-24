#include "pentoolwork.h"
#include <fstream>
#include <QtCore/qfile.h>
#include <stddef.h>
#include <stdlib.h>
#include "./bin/mat/rt_nonfinite.h"
#include "./bin/mat/test.h"
#include "./bin/mat/rtwtypes.h"
#include "./bin/mat/test_types.h"
#include "./bin/mat/test_terminate.h"
#include "./bin/mat/test_emxAPI.h"
#include "./bin/mat/test_initialize.h"
double first = 0, second = 0;

//matlabCoder生成的C的fft
void fft(QVector<int> &Id, QVector<int> &Qd, int len, QVector<Complex> &output) {
	test_initialize();
	emxArray_creal_T* fp1;
	emxInitArray_creal_T(&fp1, 2);

	int iv0[2] = { 1, len };
	emxArray_real_T* Id1 = emxCreateND_real_T(2, iv0);
	emxArray_real_T* Qd1 = emxCreateND_real_T(2, iv0);

	for (int i = 0; i < len; i++) {
		Id1->data[i] = Id[i];
		Qd1->data[i] = Qd[i];
	}

	test(Id1, Qd1, fp1);

	for (int i = 0; i < len; i++) {
		output[i] = { fp1->data[i].re , fp1->data[i].im };
	}

	emxDestroyArray_creal_T(fp1);
	emxDestroyArray_real_T(Qd1);
	emxDestroyArray_real_T(Id1);
	test_terminate();
}

void Work::task1()
{
	QVariantMap outTip;
	outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
	outTip.insert("sateName", nowProject.sateName);
	outTip.insert("info", "开始项目预处理");
	emit sendMsg(outTip);

	int temp = 0;
	bool down = true;
	int LENGTH = 16352;
	int BEISHU = 1;
	int datalen = LENGTH / 2;
	QVector<int> Id(datalen * BEISHU);
	QVector<int> Qd(datalen * BEISHU);
	//假数据
	for (int i = 0; i < datalen * BEISHU; i++) {
		Id[i] = temp;
		Qd[i] = 0;
		
		if (down) {
			if (temp > -8200) {
				temp -= 200;
			}
			else {
				down = false;
			}
		}
		else {
			if (temp < 8200) {
				temp += 200;
			}
			else {
				down = true;
			}
		}
	}
	
	//显示波形和频谱
	double fsI = 100000.0;
	QVector<double> ti(datalen * BEISHU), ft(datalen * BEISHU);
	QVector<double> fp(datalen * BEISHU);
	QVector<double> iqAbs(datalen * BEISHU);
	QVector<Complex> fftOut(datalen * BEISHU);
	double maxComplex = -99999.0, max_fp = -99999.0, min_fp = 99999.0;

	QVariantMap progressMap;
	for (int i = 0; i < datalen; i++) {
		ti[i] = i / fsI * 1e3;
		ft[i] = ((i + 1) * fsI / datalen - fsI / 2) / 1e3;
		double tempIQ = sqrt(Id[i] * Id[i] + Qd[i] * Qd[i]);
		if (tempIQ > maxComplex) maxComplex = tempIQ;
	}
	for (int i = datalen, j = 0, k = 1; i < BEISHU * datalen; i++, j++) {
		if (j == datalen) {
			j = 0;
			k++;
		}
		ti[i] = ti[i - datalen * k] + j / fsI * 1e3;
		ft[i] = ft[i - datalen * k] + ((j + 1) * fsI / datalen - fsI / 2) / 1e3;
	}

	//matlabCoder的fft
	fft(Id, Qd, datalen * BEISHU, fftOut);
	mathfunc.complexAbs(fftOut, datalen * BEISHU, iqAbs);
	mathfunc.fftshift(iqAbs, fp, datalen * BEISHU);
	for (int i = 0; i < datalen * BEISHU; i++) {
		fp[i] = 20 * log10(fp[i] + 1e-6);
		if (fp[i] > max_fp) max_fp = fp[i];
		if (fp[i] < min_fp) min_fp = fp[i];
	}

	progressMap["progress"] = 100;
	emit sendProgress(progressMap);

	if (proMap["tuflag"].toBool() == true) {
		QVariantMap outputMap;
		outputMap.insert("min_ti", 0);
		outputMap.insert("max_ti", (datalen - 1) / fsI * 1e3);
		outputMap.insert("min_IQ", -5 - maxComplex);
		outputMap.insert("max_IQ", maxComplex + 5);
		outputMap.insert("max_ft", fsI / 2000.0);
		outputMap.insert("min_ft", (fsI / datalen - fsI / 2) / 1e3);
		outputMap.insert("max_fp", max_fp);
		outputMap.insert("min_fp", min_fp);

		outputMap.insert("ti", QVariant::fromValue(ti));
		outputMap.insert("id", QVariant::fromValue(Id));
		outputMap.insert("qd", QVariant::fromValue(Qd));
		outputMap.insert("ft", QVariant::fromValue(ft));
		outputMap.insert("fp", QVariant::fromValue(fp));
		emit sendInputRsData(outputMap);
	}

	outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
	outTip["sateName"] = nowProject.sateName;
	outTip["info"] = "项目预处理完毕";
	emit sendMsg(outTip);
}