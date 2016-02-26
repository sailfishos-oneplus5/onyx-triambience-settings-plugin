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

        if (stack.contains(parts.at(0)))
            return stack.value(parts.at(0));

        int reqWidth = parts.at(1).toInt();
        int reqHeight = parts.at(2).toInt();

        QString filename = "/" + QUrl(parts.at(0)).toString(QUrl::RemoveScheme);
        QImage img;
        QSize originalSize;
        QImageReader ir(filename);

        if (!ir.canRead())
            return img;

        originalSize = ir.size();

        if (size)
            *size = originalSize;

        img = ir.read();

        QImage scaled = img.scaledToWidth(reqWidth);

        QRect rect(0, (scaled.height()-reqHeight)/2, reqWidth, reqHeight);

        QImage cropped = scaled.copy(rect);

        stack.insert(parts.at(0), cropped);

        return cropped;
    }

private:
    QMap<QString, QImage> stack;
};

#endif // IMAGEPROVIDER_H
