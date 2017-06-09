FROM php:7.0-apache

MAINTAINER hui <huiyao351@163.com>

ADD conf/php.ini /usr/local/etc/php/php.ini
ADD conf/vhosts.conf /etc/apache2/sites-enabled/vhosts.conf
ADD conf/apache.template /etc/apache2/sites-enabled/apache.template

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load 

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
		git \
		gcc \
		make \
        bzip2 \
		libbz2-dev \
		libmemcached-dev \
		libpcre3-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd mcrypt mbstring  bz2 ctype zip pdo pdo_mysql
	
#安装Memcached扩展，不需要的可以删除
WORKDIR /usr/src/php/ext/
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached.git \
	&& docker-php-ext-configure php-memcached \
	&& docker-php-ext-install php-memcached \
	&& rm -rf php-memcached
	
#Composer
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer


RUN git clone https://github.com/huiyao351/orgdev.git \
	&& cp -r orgdev/. /var/www/html \
	&& chmod -R 0777 /var/www/html \
	&& cd /var/www/html/ \
	&& composer install \
	&& php artisan clear-compiled \
	&& php artisan optimize \
	&& php artisan key:generate

COPY apache2-foreground /usr/local/bin/
RUN chmod 0777 /usr/local/bin/apache2-foreground \
	&& chmod 0777 /var/www/html/public/uploads

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]