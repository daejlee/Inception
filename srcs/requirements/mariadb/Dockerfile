#Dockerfile
FROM alpine:3.17

RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
#MariaDB의 실행 시 필요한 소켓 파일이 위치할 곳
RUN apk update && apk upgrade
RUN     apk add mariadb mariadb-client

COPY ./tools/init_db.sh /tmp/init_db.sh
#컨테이너 내부 경로로 복사
RUN chown -R mysql:mysql /run/mysqld
#/run/mysqld 디렉토리 소유자를 mysql:mysql로 변경. MariaDB가 소켓 파일에 엑세스 가능하게.

RUN sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
#MariaDB 서버 설정 파일에서 bind-address 옵션 수정, 0.0.0.0으로. 이로써 모든 IP 주소로부터의 연결을 수락

RUN chmod +x /tmp/init_db.sh

EXPOSE 3306
#컨테이너가 3306포트로 네트워크 트래픽을 수신하도록 포트 노출

ENTRYPOINT ["sh", "/tmp/init_db.sh"]
#컨테이너 시작 시 init_db.sh 실행토록 설정. db초기화 및 설정을 담당.