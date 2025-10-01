#!/bin/bash

PUBKEY="/home/ansible/.ssh/id_rsa.pub"
TARGET="/home/ansible"
HOSTS=("192.168.56.10" "192.168.56.11" "192.168.56.12" "localhost")
USER="vagrant"

if [ ! -f "$PUBKEY" ]; then
  echo "❌ Публичный ключ не найден: $PUBKEY"
  exit 1
fi

for HOST in "${HOSTS[@]}"; do
  echo "🔗 Настраиваю SSH-доступ на $HOST..."

  cat "$PUBKEY" | ssh "$USER@$HOST" "sudo tee $TARGET/.ssh/authorized_keys > /dev/null && sudo chmod 600 $TARGET/.ssh/authorized_keys && sudo chown ansible:ansible $TARGET/.ssh/authorized_keys"

  echo "✅ Готово для $HOST"
done
