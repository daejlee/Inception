NAME=inception
DOCKER_COMPOSE_PATH=./srcs/docker-compose.yml

all: dir build up

dir:
        mkdir -p /home/daejlee/data/db-data
        mkdir -p /home/daejlee/data/wp-data

build:
        docker compose -f $(DOCKER_COMPOSE_PATH) build #-f -> 컴포즈 파일의 경로 지정.
#build는 도커파일을 참조하여 각 서비스의 이미지를 빌드한다.

up:
        docker compose -f $(DOCKER_COMPOSE_PATH) up -d
#up은 이미지를 사용하여 컨테이너를 실행한다.

down:
        docker compose -f $(DOCKER_COMPOSE_PATH) down

clean:
        docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes
				#--volumes 옵션은 컨테이너와 함께 볼륨을 삭제한다. 완전 초기 상태로 돌아간다.

fclean: clean
        docker system prune -a #사용되지 않는 컨테이너, 네트워크, 이미지, 볼륨 삭제
        sudo rm -rf /home/daejlee/data

.PHONY: dir build up clean fclean