export TAG := $(shell grep ver VERSION | cut -d '=' -f 2)
export APP_SHA256 := $(shell grep sha256 VERSION | cut -d '=' -f 2)
export BUILD_DATE := $(shell date +'%Y%m%d')


help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## 构建镜像
	docker build --build-arg VERSION=$(TAG) --build-arg APP_SHA256=$(APP_SHA256) -t hub.qucheng.com/app/gogs:$(TAG)-$(BUILD_DATE) -f Dockerfile .

push: ## push 镜像到 hub.qucheng.com
	docker push hub.qucheng.com/app/gogs:$(TAG)-$(BUILD_DATE)

docker-push: ## push 镜像到 hub.docker.com
	docker tag hub.qucheng.com/app/gogs:$(TAG)-$(BUILD_DATE) easysoft/gogs:$(TAG)-$(BUILD_DATE)
	docker tag easysoft/gogs:$(TAG)-$(BUILD_DATE) easysoft/gogs:latest
	docker push easysoft/gogs:$(TAG)-$(BUILD_DATE)
	docker push easysoft/gogs:latest

run: ## 运行
	docker-compose -f docker-compose.yml up -d

ps: ## 运行状态
	docker-compose -f docker-compose.yml ps

stop: ## 停服务
	docker-compose -f docker-compose.yml stop
	docker-compose -f docker-compose.yml rm -f

restart: build clean ps ## 重构

clean: stop ## 停服务
	docker-compose -f docker-compose.yml down
	docker volume prune -f

logs: ## 查看运行日志
	docker-compose -f docker-compose.yml logs
