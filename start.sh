#!/bin/bash

# 導出 DATABASE_URL 環境變量
export DATABASE_URL=postgres://superuser:superpassword@db/todo

# 等待一段時間以確保數據庫已經啟動
echo "Waiting for the database to start..."
sleep 15

# 使用 diesel 進行設置和遷移
echo "Running diesel setup..."
/usr/local/cargo/bin/diesel setup

echo "Running diesel migrations..."
/usr/local/cargo/bin/diesel migration run

# 啟動應用程序
/usr/src/actixdemo/target/release/actixdemo
