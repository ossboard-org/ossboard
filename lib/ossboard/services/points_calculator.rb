module Services
  class PointsCalculator
    include Import[
      point_repo: 'repositories.point',
      task_repo: 'repositories.task'
    ]

    def call(user)
      if point = user.points.first
        point_repo.update(point.id, points_params(user))
      else
        point_repo.create(points_params(user))
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
        developer:  points(task_repo.assigned_tasks_for_user(user)),
        user_id:    user.id
      }
    end

    def points(tasks)
      tasks.map{ |t| POINTS_FOR_STATUS[t.status] }.inject(:+) || 0
    end
  end
end
