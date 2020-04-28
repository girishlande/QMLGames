#include "mapper.h"

Mapper::Mapper(QObject *parent) : QObject(parent)
{

}

int Mapper::getX(int position)
{
    int row = position / 10;
    int col = position % 10;
    if (col==0) {
        row = row - 1;
        col = 10;
    }
    if (row%2==1) {
        col = 11 - col;
    }
    row = 10 - row;
    int x = (col-1)*100;
    return x;
}

int Mapper::getY(int position)
{
    int row = position / 10;
    int col = position % 10;
    if (col==0) {
        row = row - 1;
        col = 10;
    }
    if (row%2==1) {
        col = 11 - col;
    }
    row = 10 - row;
    int y = (row-1)*100;
    return y;
}
