class CalculatePointsWorker
  include Sidekiq::Worker
  include Import['services.points_calculator']

  def perform
    UserRepository.new
      .all_with_points_and_tasks
      .each { |user| points_calculator.call(user) }
  end
end
