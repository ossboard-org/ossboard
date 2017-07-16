class CalculatePointsWorker
  include Sidekiq::Worker

  def perform
    UserRepository.new
      .all_with_points_and_tasks
      .each { |user| Container['services.points_calculator'].call(user) }
  end
end
