# 使用官方 Rust 基本映像作為基礎
FROM rust:1.72 AS build

# 設置工作目錄
WORKDIR /usr/src/actixdemo

# 複製您的專案到映像中
COPY . .

# 安裝 diesel CLI 和必要的工具
RUN cargo install diesel_cli --no-default-features --features postgres
RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/*

# 建立應用
RUN cargo build --release

# 複製 migrations 目錄和啟動腳本
COPY migrations /usr/src/actixdemo/migrations
COPY start.sh /usr/src/actixdemo/start.sh

# 給予腳本執行權限
RUN chmod +x /usr/src/actixdemo/start.sh

# 使用啟動腳本作為啟動命令
CMD ["/bin/bash", "/usr/src/actixdemo/start.sh"]