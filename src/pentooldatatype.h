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
	int     mbId;//Ŀ��id
	QString name;//����
	double  longitude;//����
	double  latitude;//ά��
	double  height;//�߶�
	double  Vx;//x���ٶ�
	double  Vy;//y���ٶ�
	double  Vz;//z���ٶ�
	double  timeStep;//ʱ�䲽��
	int     numberTimes;//����

	//TF
	double tuningFrequency;//��гƵ��
	double signalFrequency;//�ź�Ƶ��
	//SN
	double snr;//�����
};

struct sateClass {
	int     sateId;//����id
	QString name;//����
	double	height;//�߶�
	double	timeStep;//ʱ�䲽��
	int		numberTimes;//����
	double	distance;//����
	int		sateNumbers;//��������
	bool	fixPD;//�Ƿ��������
	QString xlsx;//�������ļ��ļ���
};

struct projectClass {
	int			 projectId;//����id
	QString		 name;//��Ŀ����
	QString		 sateName;//��������
//	QString      mbNameList;//Ŀ���б�
	QString		 editTime;//�޸�ʱ��

	QString		 modulation;//���Ʒ���
	double		 nosurearg;//����Ƶ��/��������/ʱ���϶
	double		 outputSamplingRate;//���������
	double		 allTime;//��ʱ��
};

struct SearchMbData {
	QString name;//Ŀ������
	QVector<double> ti;//ʱ��
	QVector<double> longitude;//����
	QVector<double> latitude;//ά��
	QVector<double> shicha;//ʱ��
	QVector<double> pincha;//Ƶ��
	QVector<double> pinyi;//Ƶ��
	QVector<double> fangweijiao;//��λ��
	QVector<double> fuyangjiao;//������
};

struct SearchSateData {
	QString name;//Ŀ������
	QVector<double> ti;//ʱ��
	QVector<double> longitude;//����
	QVector<double> latitude;//ά��
};

Q_DECLARE_METATYPE(mbClass);
Q_DECLARE_METATYPE(sateClass);
Q_DECLARE_METATYPE(projectClass);
Q_DECLARE_METATYPE(SearchMbData);
Q_DECLARE_METATYPE(SearchSateData);

#endif // PRNTOOLDATATYPE_H
