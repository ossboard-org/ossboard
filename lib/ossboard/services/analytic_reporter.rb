class AnalyticReporter
  def call
    {
      labels: last_month_list.map(&:to_s),
      tasks: {
        in_progress: last_month_list.map { |day| in_progress_tasks_by_day[day]&.count || 0 },
        assigned: last_month_list.map { |day| assigned_tasks_by_day[day]&.count || 0 },
        closed: last_month_list.map { |day| closed_tasks_by_day[day]&.count || 0 },
        done: last_month_list.map { |day| complited_tasks_by_day[day]&.count || 0 }
      },
      users: last_month_list.map { |day| users_by_days[day]&.count || 0 }
    }
  end

  private

  def users_by_days
    @users_by_days ||= UserRepository.new.all_from_date(ONE_MONTH_AGO).group_by{ |u| u.created_at.to_date }
  end

  def closed_tasks_by_day
    @closed_tasks_by_day ||= task_repo.all_from_date(ONE_MONTH_AGO, Task::VALID_STATUSES[:closed])
      .group_by{ |task| task.created_at.to_date }
  end

  def assigned_tasks_by_day
    @assigned_tasks_by_day ||= task_repo.all_from_date(ONE_MONTH_AGO, Task::VALID_STATUSES[:assigned])
      .group_by{ |task| task.created_at.to_date }
  end

  def in_progress_tasks_by_day
    @in_progress_tasks_by_day ||= task_repo.all_from_date(ONE_MONTH_AGO, Task::VALID_STATUSES[:in_progress])
      .group_by{ |task| task.created_at.to_date }
  end

  def complited_tasks_by_day
    @complited_tasks_by_day ||= task_repo.all_from_date(ONE_MONTH_AGO, Task::VALID_STATUSES[:done])
      .group_by{ |task| task.created_at.to_date }
  end

  def last_month_list
    @last_month_list ||= (ONE_MONTH_AGO..Date.today)
  end

  def task_repo
    @task_repo ||= TaskRepository.new
  end

  ONE_MONTH_AGO = Date.today - 30
end
