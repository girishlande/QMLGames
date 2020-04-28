#ifndef MAPPER_H
#define MAPPER_H

#include <QObject>

class Mapper : public QObject
{
    Q_OBJECT
public:
    explicit Mapper(QObject *parent = nullptr);

    Q_INVOKABLE int getX(int position);
    Q_INVOKABLE int getY(int position);

signals:

public slots:
};

#endif // MAPPER_H
