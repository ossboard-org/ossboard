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

    def contact_with_mentor_link
      subject = "OSSBoard: #{task.title}"
      link_to 'Contact with mentor', "mailto:#{author.email}?subject=#{subject}", class: 'btn btn-contact task__contact'
    end
  end
end
