#wp.sh
if [ ! -f "/var/www/html/index.php" ]; then
#워드프레스 설치 여부 체크 후 진행
  wp core download
	#워드프레스 코어 소스 다운로드. wp-cli.phar로 wp 명령 실행
        wp config create --dbhost=mariadb:3306 --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL>
				#wp-config.php파일 생성. 필요 DB연결 정보와 함께 실행.
	wp core install --url=$WP_URL --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_MAIL --skip-email
	#워드프레스 설치.
  wp user create $WP_USER_NAME $WP_USER_MAIL --user_pass=$WP_USER_PASS
	#새로운 워드프레스 사용자 생성.
fi

php-fpm81 --nodaemonize
#PHP-FPM 서버 실행. 데몬 모드가 아닌 포그라운드에서 실행