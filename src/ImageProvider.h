#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QImageReader>

class ImageProvider : public QQuickImageProvider
{
public:
    ImageProvider() : QQuickImageProvider(QQuickImageProvider::Image)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize)
    {
        Q_UNUSED(requestedSize)

        QStringList parts = id.split("?");

        if (parts.count() != 3)
        {
            qWarning() << "Invalid image requested";
            return QImage();
        }

        if (previewCache.contains(parts.at(0)))
            return previewCache.value(parts.at(0));

        int reqWidth = parts.at(1).toInt();
        int reqHeight = parts.at(2).toInt();

        QString filename = "/" + QUrl(parts.at(0)).toString(QUrl::RemoveScheme);
        QImage originalImg;
        QImageReader ir(filename);

        if (!ir.canRead())
            return QImage();

        if (size)
            *size = ir.size();

        originalImg = ir.read();

        QImage scaled = originalImg.scaledToWidth(reqWidth);

        QRect rect(0, (scaled.height()-reqHeight)/2, reqWidth, reqHeight);

        QImage cropped = scaled.copy(rect);

        previewCache.insert(parts.at(0), cropped);

        return cropped;
    }

private:
    QMap<QString, QImage> previewCache;
};

#endif // IMAGEPROVIDER_H
