class CalculatePointsWorker
  include Sidekiq::Worker

  def perform
    users.each do |user|
      if user.points.first
        PointRepository.new.update(user.points.first.id, maintainer: maintainer_points(user))
      else
        @point = PointRepository.new.create(user_id: user.id, maintainer: maintainer_points(user))
      end
    end
  end

private

  POINTS_FOR_STATUS = {
    'in progress' => 1,
    'assigned' => 3,
    'closed' => 2,
    'done' => 5
  }

  def users
    @users ||= UserRepository.new.aggregate(:points, :tasks).as(User).to_a
  end

  def maintainer_points(user)
    user.tasks.map{ |t| POINTS_FOR_STATUS[t.status] }.inject(:+) || 0
  end
end
