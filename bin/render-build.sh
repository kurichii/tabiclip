#!/usr/bin/env bash

set -e

# データベースのマイグレーション
bin/rails db:migrate

# seedsデータの適用
# bin/rails db:seed