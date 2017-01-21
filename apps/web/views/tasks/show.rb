module Web::Views::Tasks
  class Show
    include Web::View

    def title
      "OSSBoard: #{task.title}"
    end

    def task_body
      raw(task.body)
    end

    def tasks_active?
      true
    end

    def author_information
      html.div(class: 'task__author') do
        text('Posted by')
        a(href: routes.user_path(author.login)) do
          img class: 'task__author-avatar', src: author.avatar_url
          text(author.name || author.login)
        end
        text('3 weeks ago')
      end
    end

    def link_to_original_issue
      return if task.issue_url.nil? || task.issue_url.empty?
      link_to '(Original issue)', task.issue_url, target: "_blank"
    end

    def contact_with_mentor_link
      link_to 'Contact mentor (Gitter)', "https://gitter.im/#{author.login}", target: '_blank', class: 'contact-mentor-link'
    end

    def task_status_actions
      return unless current_user.author?(task)
      return unless [Task::VALID_STATUSES[:in_progress], Task::VALID_STATUSES[:assigned]].include?(task.status)

      html.div(class: 'task__status') do
        if task.status == Task::VALID_STATUSES[:in_progress]
          form(action: "/task_status/#{task.id}", method: "POST") do
            input(type: "hidden", name: "_method", value: "PATCH")
            input(type: "hidden", name: "status",  value: "assigned")
            input(name: "assignee_username", value: "", placeholder: 'Assignee @github', class: 'assign-user')
            input(class: 'btn btn-assign', type: "submit", value: "Assign")
          end
        else
          form(action: "/task_status/#{task.id}", method: "POST") do
            input(type: "hidden", name: "_method", value: "PATCH")
            input(type: "hidden", name: "status",  value: "done")
            input(class: 'btn btn-done', type: "submit", value: "Completed")
          end

          form(action: "/task_status/#{task.id}", method: "POST") do
            input(type: "hidden", name: "_method", value: "PATCH")
            input(type: "hidden", name: "status",  value: "closed")
            input(class: 'btn btn-close', type: "submit", value: "Closed")
          end
        end
      end
    end

    def link_to_edit_task
      if current_user.can_edit_task?(task)
        link_to 'Edit', routes.edit_task_path(task.id), class: 'btn btn-back'
      end
    end

    def task_status
      return if task.status == Task::VALID_STATUSES[:in_progress]
      html.span { "(#{task.status})" }
    end
  end
end
