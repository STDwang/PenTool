#ifndef MATHFUTION_H
#define MATHFUTION_H
#include "./pentooldatatype.h"
class mathFuntions {

public:
    //向0取整
    int fix(double in)
    {
        if (ceil(in) == in)
            return in;
        if (in >= 0)
            return ceil(in) - 1;
        else
            return ceil(in);
    }

    //找最小值
    double Min(QVector<double> a)
    {
        int count, lowest;
        lowest = a[0];
        int SIZE = a.size();//计算元素个数

        for (count = 0; count < SIZE; count++)
        {
            if (a[count] < lowest)
                lowest = a[count];
        }
        return lowest;
    }

    Complex comExp(double x, double y)
    {
        /*
            求e的x + yi复数次幂
        */
        //comDouble Y;
        //Y.real.push_back(exp(x) * cos(y));
        //Y.imag.push_back(exp(x) * sin(y));
        return { exp(x) * cos(y) , exp(x) * sin(y) };
    }

    double sincEasy(double *x, int len, int index) {
        double temp = PI * x[index];
        double y;
        if (temp == 0) {
            y = 0.0;
        }
        else {
            y = sin(temp) / temp;
        }
        return y;
    }

    //一个复数绝对值
    double absCom(double id, double qd)
    {
        double out = sqrt(id * id + qd * qd);
        return out;
    }
    
    //取余数
    double MOD(double a, double b) 
    {
        return a - a * int(a / b);
    }

    //获取多普勒频移
    double getdfreq(double rr,Coor mbWZ,Coor satWZ,double freq,int i)
    {
        double x1, y1, z1, vr, vx1, vy1, vz1, cyx, dpl_df;
        x1 = (satWZ.x[i] - mbWZ.x[i]) / rr;//指向x轴的单位向量
        y1 = (satWZ.y[i] - mbWZ.y[i]) / rr;//指向y轴的单位向量
        z1 = (satWZ.z[i] - mbWZ.z[i]) / rr;//指向z轴的单位向量

        vr = sqrt((mbWZ.vx[i] - satWZ.vx[i])*(mbWZ.vx[i] - satWZ.vx[i]) +
                  (mbWZ.vy[i] - satWZ.vy[i])*(mbWZ.vy[i] - satWZ.vy[i]) +
                  (mbWZ.vz[i] - satWZ.vz[i])*(mbWZ.vz[i] - satWZ.vz[i]));
        vx1 = (mbWZ.vx[i] - satWZ.vx[i]) / vr;//速度x轴单位向量
        vy1 = (mbWZ.vy[i] - satWZ.vy[i]) / vr;//速度x轴单位向量
        vz1 = (mbWZ.vz[i] - satWZ.vz[i]) / vr;//速度x轴单位向量

        //在地球指教坐标系中的向量夹角余弦
        cyx = x1 * vx1 + vy1 * y1 + z1 * vz1;
        dpl_df = freq * vr*cyx / 300 / 1e6;

        return dpl_df;
    }

    //滤波器系数
    void fir1(int lbflen, double Wn[], double lbf[])
    {
        /*
            未写排错  检查输入有需要自己进行完善
            原matlab函数fir(j, wn)	【函数默认使用hamming】

            参数输入介绍：
                j：  对应matlab的fir1里的阶数j
                Wn:  对应matlab的fir1里的阶数Wn，但应注意传进
                         来的数据应存在一个vector的double数组里。

            参数输出介绍：
                        vector <double>的一个数组，里面存的是长度
                        为j的滤波器系数。
        */

        //在截止点的左端插入0（在右边插入1也行）
        //使得截止点的长度为偶数，并且每一对截止点对应于通带。
        //if (Wn.size() == 1 || Wn.size() % 2 != 0) {
        //	Wn.insert(Wn.begin(), 0.0);
        //}
        double alpha = 0.5 * (lbflen - 1);
        double *m = new double[lbflen];
        for (int i = 0; i < lbflen; i++) {
            m[i] = i - alpha;
            lbf[i] = 0;
        }

        double *R_sin = new double[lbflen];
        double *L_sin = new double[lbflen];
        for (int i = 0; i < 2;) {
            double left = Wn[i];
            double right = Wn[i + 1];
            for (int j = 0; j < lbflen; j++) {
                R_sin[j] = right * m[j];
                L_sin[j] = left * m[j];
            }
            for (int j = 0; j < lbflen; j++) {
                lbf[j] += right * sincEasy(R_sin, lbflen, j);
                lbf[j] -= left * sincEasy(L_sin, lbflen, j);
            }

            i = i + 2;
        }

        // 应用窗口函数，这里和matlab一样
        // 默认使用hamming，要用别的窗可以去matlab查对应窗的公式。
        for (int i = 0; i < lbflen; i++)
        {
            double Win = 0.54 - 0.46*cos(2.0 * PI * i / (lbflen - 1));	//hamming窗系数计算公式
            lbf[i] *= Win;
        }

        // 如果需要，现在可以处理缩放.
        if (true) {
            double left = Wn[0];
            double right = Wn[1];
            double scale_frequency = 0.0;
            if (left == 0)
                scale_frequency = 0.0;
            else if (right == 1)
                scale_frequency = 1.0;
            else
                scale_frequency = 0.5 * (left + right);

            double s = 0.0;
            for (int i = 0; i < lbflen; i++) {
                double c = cos(PI * m[i] * scale_frequency);
                s += lbf[i] * c;
            }
            for (int i = 0; i < lbflen; i++) {
                lbf[i] /= s;
            }
        }
        delete[] m;
        delete[] R_sin, L_sin;
    }

    //fir滤波
    void filter(double lbf[], int lbfLen, double x_dreal[], double x_dimag[], int x_dLen, comDoubleC& temp1_iq)
    {
        /*
            注意：该函数仅实现了a为标量且为1时的函数滤波！！！
            参数介绍：
            lbf：		滤波器系数
            x_dreal: 复数实部
            x_dimag: 复数虚部

            temp1_iq：结果---在函数外管理内存

            公式：(a = 1时)
            当 i < 滤波器阶数 时有:
                Y[i] = ∑b[j]*j[i-j] (下限j=0, 上限j<i)
            当 i > 滤波器阶数 时有:
                Y[i] = ∑b[j]*j[i-j] (下限j=0, 上限j<滤波器阶数)
        */
        double real;
        double imag;
        int i, j;
        for (i = 0; i < lbfLen; i++)
        {
            real = 0.0;
            imag = 0.0;
            for (j = 0; j <= i; j++) {
                real += lbf[j] * x_dreal[i - j];
                imag += lbf[j] * x_dimag[i - j];
            }
            temp1_iq.real[i] = real;
            temp1_iq.imag[i] = imag;
        }
        for (i = lbfLen; i < x_dLen; i++) {
            real = 0.0;
            imag = 0.0;
            for (j = 0; j < lbfLen; j++) {
                real += lbf[j] * x_dreal[i - j];
                imag += lbf[j] * x_dimag[i - j];
            }
            temp1_iq.real[i] = real;
            temp1_iq.imag[i] = imag;
        }
    }

    //复数插值
    void Cominterp1(double Ti[], int Tilen, double To[], int Tolen, int I_Id[], int Q_Id[], comDoubleC& bh_IQ) {
        /*
        参数介绍
        输入：(数据类型都为double类型的vector数组)
        请注意：我这里的Ti和To都是排好序的
            Ti： 已有的点的x坐标的值
            To： 插入的点的X坐标的值

            I_Id:已有的点实部的y坐标的值
            Q_Id:已有的点虚部的y坐标的值

        公式：Y[i] = y[i-1] + (y[i] - y[i-1]) * (X[i] - x[i-1])

        输出：插入的点的实部和虚部的Y坐标的值以复数的形式返回

                数据类型为自定义复数，
                实部虚部都是一个double类型的vector数组
        */
        double real;
        double imag;
        double maxTi = Ti[Tilen - 1];
        int before = 1;
        int i, j;
        for (i = 0; i < Tolen; i++) {
            //待插入点在定义域右边
            if (To[i] >= maxTi) {
                bh_IQ.real[i] = (I_Id[Tilen - 1] - I_Id[Tilen - 2]) / (Ti[Tilen - 1] - Ti[Tilen - 2]) * (To[i] - Ti[Tilen - 1]) + I_Id[Tilen - 1];
                bh_IQ.imag[i] = (Q_Id[Tilen - 1] - Q_Id[Tilen - 2]) / (Ti[Tilen - 1] - Ti[Tilen - 2]) * (To[i] - Ti[Tilen - 1]) + Q_Id[Tilen - 1];
            }
            else {
                for (j = before; j < Tilen; j++) {
                    if (To[i] <= Ti[j]) {
                        bh_IQ.real[i] = (I_Id[j] - I_Id[j - 1]) / (Ti[j] - Ti[j - 1]) * (To[i] - Ti[j - 1]) + I_Id[j - 1];
                        bh_IQ.imag[i] = (Q_Id[j] - Q_Id[j - 1]) / (Ti[j] - Ti[j - 1]) * (To[i] - Ti[j - 1]) + Q_Id[j - 1];
                        before = j;
                        break;
                    }
                }
            }
        }
    }

    //整数插值
    void interp1(QVector<double> &Ti, QVector<double> &I_Id, double To[], int Tolen, double realY[])
    {
        /*
            参数介绍
            输入：(数据类型都为double类型的vector数组)
                Ti： 已有的点的x坐标的值
                To： 插入的点的X坐标的值

                I_Id:已有的点实部的y坐标的值

            公式：Y[i] = y[i-1] + (y[i] - y[i-1]) * (x[i] - x[i-1])
        */
        double maxTi = Ti[Ti.size() - 1];
        double theK;
        double real;
        int before = 1;
        for (int i = 0; i < Tolen; i++) {
            if (To[i] >= maxTi) {
                theK = (I_Id[I_Id.size() - 1] - I_Id[I_Id.size() - 2]) / (Ti[Ti.size() - 1] - Ti[Ti.size() - 2]);
                real = theK * (To[i] - Ti[Ti.size() - 1]) + I_Id[I_Id.size() - 1];
                realY[i] = real;
            }
            else {
                for (int j = before; j < Ti.size(); j++) {
                    if (To[i] <= Ti[j]) {
                        real = (I_Id[j] - I_Id[j - 1]) / (Ti[j] - Ti[j - 1]) * (To[i] - Ti[j - 1]) + I_Id[j - 1];
                        realY[i] = real;

                        before = j;
                        break;
                    }
                }
            }
        }
    }

    //傅里叶变换
    void dft(int real[], int imag[], int len, Complex Y[]) {
        /*
            real：向量实部
            imag：向量虚部
            len：数据长度
            这里仅实现对向量的快速傅里叶变换：Y = fft(X)
            计算公式可见matlab关于fft的介绍

            Y(k) = n∑(j=1) X(j)*Wn^(j-1)(k-1)
            X(j) = n∑(k=1)Y(k)*Wn^(j-1)(k-1)
            其中 Wn = e^((-2πi)/n) = cos(-2π/n)+sin(-2π/n)i
        */
        double fixed_factor = (-2 * PI) / len;
        double power, temp, uxf;
        for (int u = 0; u < len; u++) {
            uxf = u * fixed_factor;
            for (int x = 0; x < len; x++) {
                //X(j)*Wn^(j-1)(k-1)
                power = uxf * x;
                temp = imag[x] * sin(power);
                Y[u].real += real[x] * cos(power) - temp;
                Y[u].imag += real[x] * sin(power) + temp;
            }
        }
    }

    //求复数数组的绝对值
    void complexAbs(QVector<Complex>& input, int len, QVector<double>& output) {
        for (int i = 0; i < len; i++) {
            output[i] = sqrt(input[i].real * input[i].real + input[i].imag * input[i].imag);
        }
    }

    //将零频分量移到频谱中心
    template <typename T>
    void fftshift(QVector<T>& input, QVector<T>& fp, int len) {
        int mid = ceil(len / 2);
        memcpy(&fp[len - mid], &input[0], mid * sizeof(T));
        memcpy(&fp[0], &input[mid], (len - mid) * sizeof(T));
    }
};

#endif // MATHFUTION_H