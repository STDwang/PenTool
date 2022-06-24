#ifndef PRNTOOLDATATYPE_H
#define PRNTOOLDATATYPE_H

#include <QMetaType>
#include <QVector>
#include <QString>
#include <QMutex>

static QMutex ExtendReSample_Mutex;
static QMutex Sate_Mutex;
#define PI acos(-1)

struct Complex
{
	double imag;
	double real;
};

struct comInt
{
	QVector<int> real;
	QVector<int> imag;

	double time;
};

struct comIntC
{
	qint16 *real;
	qint16 *imag;
	double time;

	comIntC(int reallen, int imaglen) {
		this->real = new qint16[reallen];
		this->imag = new qint16[imaglen];
		this->time = 0;
	}
};

struct comDouble
{
	QVector<double> real;
	QVector<double> imag;

	double time;
};

struct comDoubleC
{
	double* real;
	double* imag;
	double time;
	int rsize;
	int isize;

	comDoubleC() {}

	comDoubleC(int reallen, int imaglen) {
		this->real = new double[reallen];
		this->imag = new double[imaglen];
		this->time = 0;
		this->rsize = 0;
		this->isize = 0;
	}
};

struct doubleDim2 {
	double **array;
	doubleDim2(int r, int c) {
		array = new double*[r];
		for (int i = 0; i < r; i++) {
			array[i] = new double[c];
		}
	}
};

struct int16Dim2 {
	qint16 **array;
	int16Dim2(int r, int c) {
		array = new qint16 *[r];
		for (int i = 0; i < r; i++) {
			array[i] = new qint16[c];
		}
	}
};

struct Coor
{
	QVector<double> t_s;
	QVector<double> x;
	QVector<double> y;
	QVector<double> z;
	QVector<double> vx;
	QVector<double> vy;
	QVector<double> vz;
};

struct CoorL
{
	QVector<double> Jd;
	QVector<double> Wd;
	QVector<double> high;
};

struct mbClass {
	int     mbId;//目标id
	QString name;//名称
	double  longitude;//经度
	double  latitude;//维度
	double  height;//高度
	double  Vx;//x轴速度
	double  Vy;//y轴速度
	double  Vz;//z轴速度
	double  timeStep;//时间步进
	int     numberTimes;//次数

	//TF
	double tuningFrequency;//调谐频率
	double signalFrequency;//信号频率
	//SN
	double snr;//信噪比
};

struct sateClass {
	int     sateId;//卫星id
	QString name;//名称
	double	height;//高度
	double	timeStep;//时间步进
	int		numberTimes;//次数
	double	distance;//距离
	int		sateNumbers;//卫星数量
	bool	fixPD;//是否修正相差
	QString xlsx;//测向阵文件文件名
};

struct projectClass {
	int			 projectId;//卫星id
	QString		 name;//项目名称
	QString		 sateName;//卫星名称
//	QString      mbNameList;//目标列表
	QString		 editTime;//修改时间

	QString		 modulation;//调制方法
	double		 nosurearg;//调制频率/符号速率/时间间隙
	double		 outputSamplingRate;//输出采样率
	double		 allTime;//总时间
};

struct SearchMbData {
	QString name;//目标名称
	QVector<double> ti;//时刻
	QVector<double> longitude;//经度
	QVector<double> latitude;//维度
	QVector<double> shicha;//时差
	QVector<double> pincha;//频差
	QVector<double> pinyi;//频移
	QVector<double> fangweijiao;//方位角
	QVector<double> fuyangjiao;//俯仰角
};

struct SearchSateData {
	QString name;//目标名称
	QVector<double> ti;//时刻
	QVector<double> longitude;//经度
	QVector<double> latitude;//维度
};

Q_DECLARE_METATYPE(mbClass);
Q_DECLARE_METATYPE(sateClass);
Q_DECLARE_METATYPE(projectClass);
Q_DECLARE_METATYPE(SearchMbData);
Q_DECLARE_METATYPE(SearchSateData);

#endif // PRNTOOLDATATYPE_H
