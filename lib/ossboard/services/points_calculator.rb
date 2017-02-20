class PointsCalculator < Service::Base
  def call(user)
    if point = user.points.first
      PointRepository.new.update(point.id, points_params(user))
    else
      PointRepository.new.create(points_params(user))
    end
  end

private

  POINTS_FOR_STATUS = {
    'in progress' => 1,
    'assigned' => 3,
    'closed' => 2,
    'done' => 5
  }

  def points_params(user)
    {
      maintainer: points(user.tasks),
      developer:  points(TaskRepository.new.assigned_tasks_for_user(user)),
      user_id:    user.id
    }
  end

  def points(tasks)
    tasks.map{ |t| POINTS_FOR_STATUS[t.status] }.inject(:+) || 0
  end
end
