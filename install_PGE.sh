dnf install -y wget tar
useradd -M -s /bin/false postgres_exporter

wget https://github.com/prometheus-community/postgres_exporter/releases/download/v0.15.0/postgres_exporter-0.15.0.linux-amd64.tar.gz
tar -xzf postgres_exporter-0.15.0.linux-amd64.tar.gz
cp postgres_exporter-0.15.0.linux-amd64/postgres_exporter /usr/local/bin/

cat <<EOF > /etc/systemd/system/postgres_exporter.service
[Unit]
Description=Prometheus PostgreSQL Exporter
After=network.target

[Service]
User=postgres_exporter
Environment=DATA_SOURCE_NAME=postgresql://svc_monitoring:vxonMmJjOGKOZzgPx3z0@localhost:5432/test_db1?sslmode=disable
ExecStart=/usr/local/bin/postgres_exporter
Restart=always

[Install]
WantedBy=multi-user.target
