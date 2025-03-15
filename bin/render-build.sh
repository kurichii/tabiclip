set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
# 通常
bundle exec rails db:migrate
# DBをリセットする際に実行
# DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:reset
# bundle exec rails db:seed