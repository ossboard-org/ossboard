class AnalyticReporter
  def initializer
    @user_repo = UserRepository.new
    @task_repo = TaskRepository.new
  end

  def call
    {
      labels: last_month_list,
      tasks: {
        in_progress: [],
        assigned: [],
        closed: [],
        done: []
      },
      users: last_month_list.map { |day| users_by_day[day] || 0 }
    }
  end

  private

  def users_by_day
    {}
  end

  def last_month_list
    @last_month_list ||= (ONE_MONTH_AGO..Date.today).map(&:to_s)
  end

  ONE_MONTH_AGO = Date.today - 30
end
