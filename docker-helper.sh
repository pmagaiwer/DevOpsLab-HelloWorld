#!/bin/bash

# Script helper para desenvolvimento com Docker

case "$1" in
  "build")
    echo "Construindo a imagem Docker..."
    docker build -t devopslab-helloworld:latest .
    ;;
  "run")
    echo "Executando a aplicação..."
    docker run -p 5000:5000 devopslab-helloworld:latest
    ;;
  "run-bg")
    echo "Executando a aplicação em background..."
    docker run -d -p 5000:5000 --name hello-world devopslab-helloworld:latest
    echo "Aplicação executando em http://localhost:5000"
    ;;
  "stop")
    echo "Parando a aplicação..."
    docker stop hello-world 2>/dev/null
    docker rm hello-world 2>/dev/null
    echo "Aplicação parada."
    ;;
  "compose-up")
    echo "Executando com docker-compose..."
    docker-compose up --build
    ;;
  "compose-up-bg")
    echo "Executando com docker-compose em background..."
    docker-compose up -d --build
    echo "Aplicação executando em http://localhost:5000"
    ;;
  "compose-down")
    echo "Parando docker-compose..."
    docker-compose down
    ;;
  "logs")
    echo "Visualizando logs..."
    docker logs hello-world
    ;;
  "test")
    echo "Executando testes..."
    python test.py
    ;;
  "clean")
    echo "Limpando containers e imagens..."
    docker stop hello-world 2>/dev/null
    docker rm hello-world 2>/dev/null
    docker rmi devopslab-helloworld:latest 2>/dev/null
    docker-compose down 2>/dev/null
    echo "Limpeza concluída."
    ;;
  *)
    echo "Uso: $0 {build|run|run-bg|stop|compose-up|compose-up-bg|compose-down|logs|test|clean}"
    echo ""
    echo "Comandos disponíveis:"
    echo "  build          - Construir a imagem Docker"
    echo "  run            - Executar a aplicação (foreground)"
    echo "  run-bg         - Executar a aplicação (background)"
    echo "  stop           - Parar a aplicação"
    echo "  compose-up     - Executar com docker-compose (foreground)"
    echo "  compose-up-bg  - Executar com docker-compose (background)"
    echo "  compose-down   - Parar docker-compose"
    echo "  logs           - Visualizar logs da aplicação"
    echo "  test           - Executar testes"
    echo "  clean          - Limpar containers e imagens"
    ;;
esac