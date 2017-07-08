module Services
  class AnalyticReporter
    def call
      {
        labels: last_month_list.map(&:to_s),
        tasks: {
          in_progress: count_days(in_progress_tasks_by_day_count),
          assigned: count_days(assigned_tasks_by_day_count),
          closed: count_days(closed_tasks_by_day_count),
          done: count_days(complited_tasks_by_day_count)
        },
        users: count_days(users_by_day_count)
      }
    end

  private

    def count_days(collection)
      last_month_list.map { |day| collection[day] || 0 }
    end

    def users_by_day_count
      @users_by_day ||= UserRepository.new.count_all_from_date(ONE_MONTH_AGO)
    end

    def closed_tasks_by_day_count
      tasks_by_status_and_day_count.fetch(Task::VALID_STATUSES[:closed], {})
    end

    def assigned_tasks_by_day_count
      tasks_by_status_and_day_count.fetch(Task::VALID_STATUSES[:assigned], {})
    end

    def in_progress_tasks_by_day_count
      tasks_by_status_and_day_count.fetch(Task::VALID_STATUSES[:in_progress], {})
    end

    def complited_tasks_by_day_count
      tasks_by_status_and_day_count.fetch(Task::VALID_STATUSES[:done], {})
    end

    def tasks_by_status_and_day_count
      @tasks_by_status_and_day_count ||= TaskRepository.new.all_from_date_counted_by_status_and_day(ONE_MONTH_AGO)
    end

    def last_month_list
      @last_month_list ||= (ONE_MONTH_AGO..Date.today)
    end

    ONE_MONTH_AGO = Date.today - 30
  end
end
