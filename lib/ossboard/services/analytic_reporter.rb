class AnalyticReporter
  def initializer
    @user_repo = UserRepository.new
    @task_repo = TaskRepository.new
  end

  def call
    {
      labels: last_month_list,
      tasks: {
        in_progress: last_month_list.map { |day| in_progress_tasks_by_day[day] || 0 },
        assigned: last_month_list.map { |day| assigned_tasks_by_day[day] || 0 },
        closed: last_month_list.map { |day| closed_tasks_by_day[day] || 0 },
        done: last_month_list.map { |day| complited_tasks_by_day[day] || 0 }
      },
      users: last_month_list.map { |day| users_by_day[day] || 0 }
    }
  end

  private

  def users_by_day
    {}
  end

  def closed_tasks_by_day
    {}
  end

  def assigned_tasks_by_day
    {}
  end

  def in_progress_tasks_by_day
    {}
  end

  def complited_tasks_by_day
    {}
  end

  def last_month_list
    @last_month_list ||= (ONE_MONTH_AGO..Date.today).map(&:to_s)
  end

  ONE_MONTH_AGO = Date.today - 30
end
