module Web::Views::Tasks
  class Show
    include Web::View

    def task_body
      raw(task.body)
    end

    def tasks_active?
      true
    end

    def link_to_author
      link_to author.name, routes.user_path(author.id)
    end

    def link_to_original_issue
      return if task.issue_url.nil? || task.issue_url.empty?
      link_to '(Original issue)', task.issue_url, target: "_blank"
    end

    def contact_with_mentor_link
      subject = "OSSBoard: #{task.title}"
      link_to 'Contact with mentor', "mailto:#{author.email}?subject=#{subject}", class: 'btn btn-contact task__contact'
    end

    def task_status_actions
      return unless current_user.author?(task)
      return unless task.status == Task::VALID_STATUSES[:in_progress]

      html.div(class: 'task__status') do
        form(action: "/task_status/#{task.id}", method: "POST") do
          input(type: "hidden", name: "_method", value: "PATCH")
          input(type: "hidden", name: "status",  value: "done")
          input(class: 'btn btn-done', type: "submit", value: "Complited")
        end

        form(action: "/task_status/#{task.id}", method: "POST") do
          input(type: "hidden", name: "_method", value: "PATCH")
          input(type: "hidden", name: "status",  value: "closed")
          input(class: 'btn btn-close', type: "submit", value: "Closed")
        end
      end
    end
  end
end
