set -euo pipefail

scp -r src/usr/bin/flame/backup.sh apps:/tmp/backup.sh

ssh apps "sudo mv /tmp/backup.sh /usr/bin/flame/backup"
ssh apps "sudo chmod +x /usr/bin/flame/backup"
