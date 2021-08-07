schedule_file = "config/schedule.yml"

Rails.application.reloader.to_prepare do
  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end
