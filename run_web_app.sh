#!/bin/bash

# Script para rodar a aplicação Personal Planner como web app
# Este script faz o build (se necessário) e inicia o servidor

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_DIR="$SCRIPT_DIR/build/web"
PORT=8000

echo "=========================================="
echo "Personal Planner - Web Server"
echo "=========================================="

# Verifica se o diretório build/web existe
if [ ! -d "$WEB_DIR" ]; then
    echo "❌ Diretório build/web não encontrado."
    echo "🔨 Executando flutter build web..."
    cd "$SCRIPT_DIR"
    flutter build web
    if [ $? -ne 0 ]; then
        echo "❌ Erro ao fazer build da aplicação."
        exit 1
    fi
fi

echo "✅ Iniciando servidor na porta $PORT..."
echo "🌐 Acesse: http://localhost:$PORT"
echo ""
echo "Pressione Ctrl+C para parar o servidor"
echo "=========================================="

cd "$WEB_DIR"
python3 -m http.server $PORT
