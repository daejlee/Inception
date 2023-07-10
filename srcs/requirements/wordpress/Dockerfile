#Dockerfile
FROM alpine:3.17

RUN apk update && apk upgrade
RUN     apk add php81-fpm \
                php81 \
                php81-curl \
                php81-phar \
                php81-mysqli \
                php81-iconv \
                mariadb-client
								#필요한 PHP, MariaDB클라이언트 패키지를 설치
RUN apk add curl

WORKDIR /tmp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#wp-cli.phar파일을 다운로드. 워드프레스 명령 줄 인터페이스 도구다
RUN mv wp-cli.phar /usr/local/bin
RUN chmod +x /usr/local/bin/wp-cli.phar
RUN ln -sf /usr/local/bin/wp-cli.phar /usr/local/bin/wp
#심볼릭 링크 생성

RUN mkdir -p /var/www/html
#워드프레스의 루트 디렉토리로 사용
WORKDIR /var/www/html
#작업 디렉토리를 설정

RUN sed -i 's/;chdir = \/var\/www/chdir = \/var\/www\/html/g' /etc/php81/php-fpm.d/www.conf
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php81/php-fpm.d/www.conf
#PHP-FPM의 www.conf 파일에서 설정을 수정, 작업 디렉토리를 변경

COPY ./tools/wp.sh /tmp/wp.sh
#워드프레스 설치, 설정 스크립트 복사
RUN chmod +x /tmp/wp.sh

EXPOSE 9000
#9000포트로 PHP-FPM요청을 처리

ENTRYPOINT [ "sh", "/tmp/wp.sh" ]
#컨테이너 시작 시 실행