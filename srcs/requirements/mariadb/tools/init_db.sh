#init_db.sh
mkdir -p /auth_pam_tool_dir
touch /auth_pam_tool_dir/auth_pam_tool

mysql_install_db --user=mysql \
                                                                --basedir=/usr \
                                                                --datadir=/var/lib/mysql \
                                                                --skip-test-db
#MySQL 데이터베이스를 초기화한다. 사용자를 mysql로 지정하고 MySQL의 설치 및 데이터 디렉토리 경로를 지정한다. 테스트용 db를 생성하지 않도록 설정한다.
cat > /tmp/init_db_sql << EOF
#/tmp/init_db.sql 파일 생성, 입력한 내용을 해당 파일에 적는다.
FLUSH PRIVILEGES;
#권한 변경 내용을 적용
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
#$MYSQL_DATABASE라는 데이터베이스를 생성
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
#MYSQL_USER 사용자를 %호스트에 대해 생성
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
#그에게 $MYSQL_DATABASE에 대한 모든 권한 부여, root 계정 비밀번호를 $MYSQL_ROOT_PASSWORD로 변경
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

/usr/bin/mysqld -u mysql --bootstrap < /tmp/init_db_sql
#mysql DB서버 초기화를 위해 --bootstrap 옵션과 함께 실행. 위 스크립트를 사용하여 DB 설정
/usr/bin/mysqld -u mysql
#초기화된 MySQL DB 서버를 실행. mysql 사용자로 실행한다.