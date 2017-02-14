class CalculatePointsWorker
  include Sidekiq::Worker

  def perform
    users.each do |user|
      assigned_tasks = TaskRepository.new.tasks.where(assignee_username: user.login).as(Task).to_a
      points_params = {
        maintainer: points(user.tasks),
        developer: points(assigned_tasks)
      }

      if user.points.first
        PointRepository.new.update(user.points.first.id, points_params)
      else
        points_params[:user_id] = user.id
        PointRepository.new.create(points_params)
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

  def points(tasks)
    tasks.map{ |t| POINTS_FOR_STATUS[t.status] }.inject(:+) || 0
  end
end
