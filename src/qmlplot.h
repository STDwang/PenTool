#ifndef QMLPLOT_H
#define QMLPLOT_H
#pragma execution_character_set("utf-8")

#include <QtQuick>
#include <QVariantMap>
#include <QThread>
class QCustomPlot;
class QCPAbstractPlottable;
class QCPTextElement;

class DDuiBasePlotItem : public QQuickPaintedItem
{
    Q_OBJECT
public:
    DDuiBasePlotItem( QQuickItem* parent = 0 );
    virtual ~DDuiBasePlotItem();

    void paint( QPainter* painter );
    virtual void initCustomPlotUI(){}

    QCustomPlot *getPlot();
protected:
    virtual void hoverMoveEvent(QHoverEvent *event);
    virtual void mousePressEvent( QMouseEvent* event );
    virtual void mouseReleaseEvent( QMouseEvent* event );
    virtual void mouseMoveEvent( QMouseEvent* event );
    virtual void mouseDoubleClickEvent( QMouseEvent* event );
    virtual void wheelEvent( QWheelEvent *event );

    void routeMouseEvents( QMouseEvent* event );
    void routeWheelEvents( QWheelEvent* event );

public slots:
    void graphClicked( QCPAbstractPlottable* plottable );
    void onCustomReplot();
    void updateCustomPlotSize();

private:
    QCustomPlot* m_CustomPlot;
    QThread* plotThread;
};



class CustomPlotItem : public DDuiBasePlotItem
{
    Q_OBJECT
public:
    CustomPlotItem( QQuickItem* parent = 0 );
    virtual ~CustomPlotItem();

    Q_INVOKABLE void initIQCustomPlot();
    Q_INVOKABLE void initBXCustomPlot();
    Q_INVOKABLE void iqPlay(QVariantMap data);
    Q_INVOKABLE void bxPlay(QVariantMap data);

private:
    QCPTextElement *m_title;
};
#endif // QMLPLOT_H
