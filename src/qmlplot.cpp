#include "qmlplot.h"
#include "../bin/qcustomplot/qcustomplot.h"
#include <QDebug>

DDuiBasePlotItem::DDuiBasePlotItem( QQuickItem* parent ) : QQuickPaintedItem( parent ) , m_CustomPlot( new QCustomPlot() )
{
    setFlag( QQuickItem::ItemHasContents, true );
    setAcceptedMouseButtons( Qt::AllButtons );
    setAcceptHoverEvents(true);
    connect( this, &QQuickPaintedItem::widthChanged, this, &DDuiBasePlotItem::updateCustomPlotSize );
    connect( this, &QQuickPaintedItem::heightChanged, this, &DDuiBasePlotItem::updateCustomPlotSize );
}

DDuiBasePlotItem::~DDuiBasePlotItem()
{
    delete m_CustomPlot;
    m_CustomPlot = nullptr;
}

void DDuiBasePlotItem::paint( QPainter* painter )
{
    if (m_CustomPlot)
    {
        QPixmap picture( boundingRect().size().toSize() );
        QCPPainter qcpPainter( &picture );
        m_CustomPlot->toPainter( &qcpPainter );
        painter->drawPixmap( QPoint(), picture );
    }
}

QCustomPlot *DDuiBasePlotItem::getPlot()
{
    if( !m_CustomPlot){
        m_CustomPlot = new QCustomPlot;
        plotThread = new QThread;
        m_CustomPlot->moveToThread(plotThread);
    }
    return m_CustomPlot;
}

void DDuiBasePlotItem::mousePressEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}

void DDuiBasePlotItem::mouseReleaseEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}

void DDuiBasePlotItem::mouseMoveEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}

void DDuiBasePlotItem::mouseDoubleClickEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}

void DDuiBasePlotItem::wheelEvent( QWheelEvent *event )
{
    routeWheelEvents( event );
}
void DDuiBasePlotItem::graphClicked( QCPAbstractPlottable* plottable )
{
    qDebug() << Q_FUNC_INFO << QString( "Clicked on graph '%1 " ).arg( plottable->name() );
}

void DDuiBasePlotItem::routeMouseEvents( QMouseEvent* event )
{
    if (m_CustomPlot)
    {
        QMouseEvent* newEvent = new QMouseEvent( event->type(), event->localPos(), event->button(), event->buttons(), event->modifiers() );
        QCoreApplication::postEvent( m_CustomPlot, newEvent );
    }
}

void DDuiBasePlotItem::routeWheelEvents( QWheelEvent* event )
{
    if (m_CustomPlot)
    {
        QWheelEvent* newEvent = new QWheelEvent( event->pos(), event->delta(), event->buttons(), event->modifiers(), event->orientation() );
        QCoreApplication::postEvent( m_CustomPlot, newEvent );
    }
}

void DDuiBasePlotItem::hoverMoveEvent(QHoverEvent *event)
{
    //qDebug() << Q_FUNC_INFO<<event->pos();
}

void DDuiBasePlotItem::updateCustomPlotSize()
{
    if (m_CustomPlot)
    {
        m_CustomPlot->setGeometry(0, 0, (int)width(), (int)height());
        m_CustomPlot->setViewport(QRect(0, 0, (int)width(), (int)height()));
    }
}

void DDuiBasePlotItem::onCustomReplot()
{
    update();
}

////
/// \brief CustomPlotItem::CustomPlotItem
/// \param parent
///
CustomPlotItem::CustomPlotItem( QQuickItem* parent ) : DDuiBasePlotItem( parent )
{
    m_title = new QCPTextElement(getPlot(), "标题");
    getPlot()->plotLayout()->insertRow(0);
    getPlot()->plotLayout()->addElement(0, 0, m_title);
}

CustomPlotItem::~CustomPlotItem()
{
    delete m_title;
}

void CustomPlotItem::initIQCustomPlot()
{
    updateCustomPlotSize();
    //设置title
    m_title->setText("输入时频");
    m_title->setTextColor(Qt::white);
    m_title->setFont(QFont("微软雅黑", 12, QFont::Bold));

    getPlot()->addGraph();
    getPlot()->addGraph();
    getPlot()->graph( 0 )->setPen( QPen( Qt::yellow ) );
    getPlot()->graph( 1 )->setPen( QPen( Qt::green ) );
    getPlot()->graph(0)->setName("实部");
    getPlot()->graph(1)->setName("虚部");

    getPlot()->legend->setVisible(true);//显示图例
    getPlot()->legend->setBrush(QColor(45,51,59, 200));//图例背景颜色
    getPlot()->legend->setTextColor(Qt::white);//图例文字颜色

    getPlot()->setBackground(QColor(45,51,59, 200));//外层背景颜色
    getPlot()->axisRect()->setBackground(QBrush(QColor::fromRgb(34, 39, 46)));//里层背景黑色

    getPlot()->xAxis->setBasePen(QPen(Qt::white, 1));  // 轴线的画笔
    getPlot()->yAxis->setBasePen(QPen(Qt::white, 1));  // 轴线的画笔
    getPlot()->xAxis->setLabelColor(Qt::white);
    getPlot()->yAxis->setLabelColor(Qt::white);
    getPlot()->xAxis->setSubTickPen(QPen(Qt::white, 1)); // 轴子刻度线的画笔
    getPlot()->yAxis->setSubTickPen(QPen(Qt::white, 1)); // 轴子刻度线的画笔
    getPlot()->xAxis->setTickLabelColor(Qt::white);  // 轴刻度文字颜色
    getPlot()->yAxis->setTickLabelColor(Qt::white);  // 轴刻度文字颜色

    getPlot()->xAxis->setLabel( "ti" );
    getPlot()->yAxis->setLabel( "IQ" );

    getPlot()->xAxis->grid()->setZeroLinePen(Qt::NoPen);
    getPlot()->yAxis->grid()->setZeroLinePen(Qt::NoPen);

    getPlot() ->setInteractions( QCP::iRangeDrag | QCP::iRangeZoom );
    connect( getPlot(), &QCustomPlot::afterReplot, this, &CustomPlotItem::onCustomReplot );
    getPlot()->replot();
}

void CustomPlotItem::initBXCustomPlot()
{
    updateCustomPlotSize();
    //设置title
    m_title->setText("输出波形(快速傅里叶)");
    m_title->setTextColor(Qt::white);
    m_title->setFont(QFont("微软雅黑", 12, QFont::Bold));

    getPlot()->addGraph();
    getPlot()->graph(0)->setPen(QPen(QColor(49, 109, 202)));
    getPlot()->graph(0)->setName("波形");

    getPlot()->legend->setVisible(true);//显示图例
    getPlot()->legend->setBrush(QColor(45,51,59, 200));//图例背景颜色
    getPlot()->legend->setTextColor(Qt::white);//图例文字颜色

    getPlot()->setBackground(QColor(45,51,59, 200));//外层背景颜色
    getPlot()->axisRect()->setBackground(QBrush(QColor::fromRgb(34, 39, 46)));//里层背景黑色

    getPlot()->xAxis->setBasePen(QPen(Qt::white, 1));  // x轴线的画笔
    getPlot()->yAxis->setBasePen(QPen(Qt::white, 1));  // y轴线的画笔
    getPlot()->xAxis->setLabelColor(Qt::white);  // x坐标轴Label的画笔
    getPlot()->yAxis->setLabelColor(Qt::white);  // y坐标轴Label的画笔
    getPlot()->xAxis->setSubTickPen(QPen(Qt::white, 1)); // x轴子刻度线的画笔
    getPlot()->yAxis->setSubTickPen(QPen(Qt::white, 1)); // y轴子刻度线的画笔
    getPlot()->xAxis->setTickLabelColor(Qt::white);  // x轴刻度文字颜色
    getPlot()->yAxis->setTickLabelColor(Qt::white);  // y轴刻度文字颜色

    getPlot()->xAxis->setLabel( "ft" );
    getPlot()->yAxis->setLabel( "fp" );

    getPlot()->xAxis->grid()->setZeroLinePen(Qt::NoPen);
    getPlot()->yAxis->grid()->setZeroLinePen(Qt::NoPen);
    getPlot() ->setInteractions( QCP::iRangeDrag | QCP::iRangeZoom );
    connect( getPlot(), &QCustomPlot::afterReplot, this, &CustomPlotItem::onCustomReplot );
}

void CustomPlotItem::iqPlay(QVariantMap data){
    double min_ti = data["min_ti"].toDouble();
    double max_ti = data["max_ti"].toDouble();
    double min_IQ = data["min_IQ"].toDouble();
    double max_IQ = data["max_IQ"].toDouble();
    QVector<double> ti = data["ti"].value<QVector<double>>();
    QVector<int> Id = data["id"].value<QVector<int>>();
    QVector<int> Qd = data["qd"].value<QVector<int>>();

    getPlot()->xAxis->setRange( min_ti, max_ti );
    getPlot()->yAxis->setRange( min_IQ, max_IQ );

    //自适应精简显示
    getPlot()->graph(0)->setAdaptiveSampling(true);
    getPlot()->graph(1)->setAdaptiveSampling(true);
    for(int i=0;i<ti.size();i++){
        getPlot()->graph(0)->addData(ti[i], Id[i]);
        getPlot()->graph(1)->addData(ti[i], Qd[i]);
    }
    getPlot()->replot();
}

void CustomPlotItem::bxPlay(QVariantMap data){
    double max_ft = data["max_ft"].toDouble();
    double min_ft = data["min_ft"].toDouble();
    double max_fp = data["max_fp"].toDouble();
    double min_fp = data["min_fp"].toDouble();
    QVector<double> ft = data["ft"].value<QVector<double>>();
    QVector<double> fp = data["fp"].value<QVector<double>>();

    getPlot()->xAxis->setRange( min_ft, max_ft );
    getPlot()->yAxis->setRange( min_fp, max_fp );

    //自适应精简显示
    getPlot()->graph(0)->setAdaptiveSampling(true);
    for(int i=0;i<ft.size();i++){
        getPlot()->graph(0)->addData(ft[i], fp[i]);
    }
    getPlot()->replot();
}
