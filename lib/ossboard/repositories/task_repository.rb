class TaskRepository < Hanami::Repository
  def only_approved
    tasks.where(approved: true).order(Sequel.lit('? DESC', :id)).as(Task).to_a
  end

  def not_approved
    tasks.where(approved: false).as(Task).to_a
  end

  def new_tasks
    tasks.where(approved: nil).as(Task).to_a
  end

  def all_from_date(from, status = nil)
    all_from_date_request(from, status).as(Task).to_a
  end

  def all_from_date_counted_by_status_and_day(from)
    result = all_from_date_request(from)
      .select{ [count(:id), :status, Sequel.lit('created_at::date')] }
      .group(:status, Sequel.lit('created_at::date'))
      .order(nil)
      .to_a
      .group_by(&:status)

    result.each do |status, records_by_status|
      result[status] = {}
      records_by_status.each { |record| result[status][record.created_at] = record.count }
    end
  end

  def find_by(params)
      tasks do
        if params.is_a? Hash
          if Task::VALID_STATUSES.values.include? params[:status]
            where(status: params[:status])
          end

          if Task::VALID_LANGUAGES.values.include? params[:language]
            where(language: params[:language])
          end
        end

        where(approved: true)
        order(Sequel.lit('? DESC', :id))
        as(Task).to_a
      end
  end

  def on_moderation_for_user(id)
    tasks.where(user_id: id, approved: nil).order(Sequel.lit('? DESC', :id)).as(Task).to_a
  end

  def assigned_tasks_for_user(user)
    tasks.where(assignee_username: user.login).order(Sequel.lit('? DESC', :id)).as(Task).to_a
  end

  private

  def all_from_date_request(from, status = nil)
    request = tasks.where("created_at > '#{from}'").where("created_at < '#{Time.now}'")
    request = request.where(status: status) if status
    request
  end
end
