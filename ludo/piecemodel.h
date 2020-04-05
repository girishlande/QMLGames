#ifndef PIECEMODEL_H
#define PIECEMODEL_H

#include <QAbstractListModel>
#include <qvector.h>
#include <piece.h>

class PieceModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum roles {
        IndexRole=Qt::UserRole+1,
        ColorRole,
        NameRole,
        ReachedRole,
        XposRole,
        YposRole
    };

    explicit PieceModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int,QByteArray> roleNames() const override;

    void appendPiece(Piece* piece);

private:
    QVector<Piece*> m_pieces;
};

#endif // PIECEMODEL_H
