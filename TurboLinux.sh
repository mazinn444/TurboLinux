# Made by MazinnDev

clear

if [ "$1" = "uninstall" ]; then
    echo "========== TurboLinux =========="
    echo "========== $USER =========="
    echo "========== Desinstalando =========="
    echo

    echo "[*] Removendo otimizações..."
    echo

    # Remover preload
    if dpkg -l | grep -q "preload"; then
        echo "[1] Removendo preload..."
        sudo apt-get remove -qq preload > /dev/null 2>&1
        sudo apt-get autoremove -qq -y > /dev/null 2>&1
    fi

    # Restaurar CPU para ondemand
    echo "[2] Restaurando configurações da CPU..."
    sudo cpufreq-set -g ondemand

    # Restaurar RAM para default
    echo "[3] Restaurando configurações da RAM..."
    sudo sysctl -w vm.swappiness=60

    # Restaurar SWAP para default
    echo "[4] Restaurando configurações do SWAP..."
    sudo sysctl -w vm.vfs_cache_pressure=100

    echo
    echo "Sistema restaurado com sucesso!"
    exit 0
fi

echo "========== TurboLinux =========="
echo "========== $USER =========="
echo "========== Versão 1.0 =========="

echo

echo "[*] Verificando e instalando dependências..."
echo

if ! dpkg -l | grep -q "preload"; then
    sudo apt-get install -qq preload > /dev/null 2>&1
    echo "Preload instalado com sucesso!"
else
    echo "Preload já está instalado."
fi

echo

echo "[*] Iniciando otimização..."
echo

# cpu performance
echo "[1] Otimizando CPU..."
sudo cpufreq-set -g performance

# clear cache
echo "[2] Limpeza de cache..."
sudo apt-get autoclean -qq > /dev/null 2>&1
sudo apt-get autoremove -qq -y > /dev/null 2>&1
sudo apt-get clean -qq > /dev/null 2>&1

# update
echo "[3] Atualização de pacotes..."
sudo apt update -qq > /dev/null 2>&1
sudo apt upgrade -qq -y > /dev/null 2>&1

# ram performance
echo "[4] Otimizando RAM..."
sudo sysctl -w vm.swappiness=10
sudo sync && sudo sysctl -w vm.drop_caches=3

# swap performance
echo "[5] Otimizando SWAP..."
sudo sysctl -w vm.vfs_cache_pressure=50 

# preload
echo "[6] Preload..."
echo 1 | sudo tee /proc/sys/kernel/preload > /dev/null 2>&1

#fim
echo
echo "[*] Otimização concluída!"
echo