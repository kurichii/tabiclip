class JobDeleteService
  def self.call(job_id)
    Rails.logger.info "「#{job_id}」を削除します"
    ss = Sidekiq::ScheduledSet.new
    job = ss.find { |job| job.args[0]["job_id"] == job_id }
    job.delete if job
  end
end
