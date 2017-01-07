class AnalyticReporter
  def initializer
    @user_repo = UserRepository.new
    @task_repo = TaskRepository.new
  end

  def call
    {
      labels: ((Date.today - ONE_MONTH)..Date.today).map(&:to_s),
      tasks: {},
      users: {}
    }
  end

  private

  ONE_MONTH = 30
end
