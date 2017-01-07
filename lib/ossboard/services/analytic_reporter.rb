class AnalyticReporter
  def initializer
    @user_repo = UserRepository.new
    @task_repo = TaskRepository.new
  end

  def call
    {
      labels: last_month_list.map(&:to_s),
      tasks: {
        in_progress: last_month_list.map { |day| in_progress_tasks_by_day[day]&.count || 0 },
        assigned: last_month_list.map { |day| assigned_tasks_by_day[day]&.count || 0 },
        closed: last_month_list.map { |day| closed_tasks_by_day[day]&.count || 0 },
        done: last_month_list.map { |day| complited_tasks_by_day[day]&.count || 0 }
      },
      users: last_month_list.map { |day| users_by_day[day]&.count || 0 }
    }
  end

  private

  # TODO: Use SQL where IN condition here
  def users_by_day
    UserRepository.new.all
      .select{ |user| last_month_list.include?(user.created_at.to_date) }
      .group_by{ |user| user.created_at.to_date }
  end

  def closed_tasks_by_day
    # TaskRepository.new.all
    #   .select{ |task| last_month_list.include?(task.created_at.to_date) && task.status == Task::VALID_STATUSES[:closed] }
    #   .group_by{ |task| task.created_at.to_date }
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
    @last_month_list ||= (ONE_MONTH_AGO..Date.today)
  end

  ONE_MONTH_AGO = Date.today - 30
end
