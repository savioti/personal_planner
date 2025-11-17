#!/bin/bash

# Script de instalação do serviço Personal Planner

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_FILE="$SCRIPT_DIR/personal-planner.service"
SYSTEMD_DIR="$HOME/.config/systemd/user"

echo "=========================================="
echo "Instalação do Personal Planner Service"
echo "=========================================="

# Cria o diretório systemd do usuário se não existir
mkdir -p "$SYSTEMD_DIR"

# Copia o arquivo de serviço
echo "📋 Copiando arquivo de serviço..."
cp "$SERVICE_FILE" "$SYSTEMD_DIR/personal-planner.service"

# Recarrega o systemd
echo "🔄 Recarregando systemd..."
systemctl --user daemon-reload

# Habilita o serviço para iniciar com o sistema
echo "✅ Habilitando serviço..."
systemctl --user enable personal-planner.service

# Inicia o serviço agora
echo "🚀 Iniciando serviço..."
systemctl --user start personal-planner.service

echo ""
echo "=========================================="
echo "✅ Instalação concluída!"
echo "=========================================="
echo ""
echo "Comandos úteis:"
echo "  Verificar status:  systemctl --user status personal-planner"
echo "  Parar serviço:     systemctl --user stop personal-planner"
echo "  Iniciar serviço:   systemctl --user start personal-planner"
echo "  Reiniciar serviço: systemctl --user restart personal-planner"
echo "  Ver logs:          journalctl --user -u personal-planner -f"
echo "  Desabilitar:       systemctl --user disable personal-planner"
echo ""
echo "🌐 A aplicação estará disponível em: http://localhost:8000"
echo "=========================================="
