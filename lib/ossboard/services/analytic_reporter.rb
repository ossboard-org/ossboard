class AnalyticReporter
  def call
    {
      labels: last_month_list.map(&:to_s),
      tasks: {
        in_progress: count_days(in_progress_tasks_by_day),
        assigned: count_days(assigned_tasks_by_day),
        closed: count_days(closed_tasks_by_day),
        done: count_days(complited_tasks_by_day)
      },
      users: count_days(users_by_days)
    }
  end

  private

  def count_days(collection)
    last_month_list.map { |day| collection[day]&.count || 0 }
  end

  def users_by_days
    @users_by_days ||= UserRepository.new.all_from_date(ONE_MONTH_AGO).group_by{ |u| u.created_at.to_date }
  end

  def closed_tasks_by_day
    tasks_by_status_and_day.fetch(Task::VALID_STATUSES[:closed], {})
  end

  def assigned_tasks_by_day
    tasks_by_status_and_day.fetch(Task::VALID_STATUSES[:assigned], {})
  end

  def in_progress_tasks_by_day
    tasks_by_status_and_day.fetch(Task::VALID_STATUSES[:in_progress], {})
  end

  def complited_tasks_by_day
    tasks_by_status_and_day.fetch(Task::VALID_STATUSES[:done], {})
  end

  def tasks_by_status_and_day
    return @tasks_by_status_and_day if @tasks_by_status_and_day
    @tasks_by_status_and_day = task_repo.all_from_date(ONE_MONTH_AGO).group_by(&:status)
    @tasks_by_status_and_day.each do |k, v|
      @tasks_by_status_and_day[k] = v.group_by { |task| task.created_at.to_date }
    end
  end

  def last_month_list
    @last_month_list ||= (ONE_MONTH_AGO..Date.today)
  end

  def task_repo
    @task_repo ||= TaskRepository.new
  end

  ONE_MONTH_AGO = Date.today - 30
end
