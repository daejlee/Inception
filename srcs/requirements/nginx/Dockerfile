#Dockerfile
FROM alpine:3.17

RUN apk update && apk upgrade
RUN apk add nginx \
                openssl

COPY ./conf/default.conf /etc/nginx/http.d
#호스트 파일을 컨테이너 내부로 복사한다.

RUN openssl req \
        -x509 \
        -days 365 \
        -nodes \
        -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=Develop/CN=daejlee's_First_Wordpress"
#OpenSSL로 새로운 자체서명 SSL인증서를 생성한다.
#생성된 인증서는 /etc/ssl/certs/nginx.crt에 저장되고 개인키는 /etc/ssl/private/nginx.key경로에 저장된다.
#-subj 옵션은 생성되는 인증서의 주체 정보를 지정한다. Country, State, Organization, Ounit, Common Name

EXPOSE 443
#호스트와 컨테이너 간의 포트 매핑. 443 포트를 노출하여 HTTPS트래픽을 처리할 수 있다.

CMD ["nginx", "-g", "daemon off;"]
#컨테이너가 시작되었을 때 실행되는 명령어. Nginx 웹 서버를 실행, 데몬 모드가 아닌 포그라운드에서 실행.