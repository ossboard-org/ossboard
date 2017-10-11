class CalculatePointsWorker
  include Sidekiq::Worker
  include Import[user_repo: 'repositories.user']
  include Import['services.points_calculator']

  def perform
    user_repo
      .all_with_points_and_tasks
      .each { |user| points_calculator.call(user) }
  end
end
