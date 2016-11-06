FROM httpd:alpine
MAINTAINER KAMO Yasuhiro <duck1218+github@gmail.com>

ENV DODONTOF_VERSION 1.48.19
ENV DOWNLOAD_URL http://www.dodontof.com/DodontoF/DodontoF_Ver.${DODONTOF_VERSION}.zip

RUN apk --no-cache add ruby ruby-json \
    && apk --no-cache add --virtual .dep wget \
    && ln -s `which ruby` /usr/local/bin/ruby

COPY config.d/httpd.conf /usr/local/apache2/conf/httpd.conf

WORKDIR /usr/local/apache2/

RUN wget $DOWNLOAD_URL -O DodontoF.zip \
    && unzip DodontoF.zip \
    && rm -rf htdocs \
    && mv DodontoF_WebSet/public_html ./htdocs \
    && mv DodontoF_WebSet/saveData ./ \
    && rm -rf DodontoF_WebSet DodontoF.zip

RUN chmod 705 htdocs/DodontoF \
    && chmod 705 htdocs/DodontoF/DodontoFServer.rb \
    && chmod 600 htdocs/DodontoF/log.txt \
    && chmod 600 htdocs/DodontoF/log.txt.0 \
    && chmod 705 htdocs/DodontoF/saveDataTempSpace \
    && chmod 705 htdocs/DodontoF/fileUploadSpace \
    && chmod 705 htdocs/DodontoF/replayDataUploadSpace \
    && chmod 705 htdocs/imageUploadSpace \
    && chmod 705 htdocs/imageUploadSpace/smallImages \
    && chown -R www-data:www-data .

RUN apk del .dep

EXPOSE 80
