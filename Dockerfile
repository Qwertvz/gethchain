# В качестве базового образа возьмем Ubuntu
FROM ubuntu:16.04

# Добавляем рабочую директорию проекта
WORKDIR /gethchain

# Перемещаем скрипт в образ
COPY ./run.sh .

# Убираем режим взаимодействия
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем списов пакетов и устанавливаем их
RUN apt-get update \
    && apt-get upgrade -y

# Добавляем репозиторий с geth и устанавливаем его
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum \
    && apt-get update \
    && apt-get install -y geth

# Устанавка разрешение на выполнение
RUN chmod +x ./run.sh

# Объявляем порты которые будут прослушиваться
EXPOSE ${GETH_HTTP_PORT}
EXPOSE ${GETH_WEBSOCKET_PORT}

# Запускаем ноду geth 
CMD ["bash", "./run.sh"]