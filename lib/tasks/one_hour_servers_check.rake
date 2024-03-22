namespace :one_hour_servers_check do
  desc '1時間以前のserverは全て削除'
  task destroy: :environment do
    Server.where(updated_at: ..Time.current.ago(1.hour)).destroy_all
  end
end
