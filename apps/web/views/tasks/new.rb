module Web::Views::Tasks
  class New
    include Web::View

    def title
      'OSSBoard: new task'
    end

    def form
      form_for task_form, id: 'task-form', class: 'task-form pure-form' do
        hidden_field :user_id, value: current_user.id

        div class: 'input' do
          text_field :title, value: task.title, placeholder: 'Title'
        end

        div class: 'input' do
          text_field :repository_name, value: task.repository_name, placeholder: 'Repository Name (optional)'
        end

        div class: 'input' do
          text_field :issue_url, value: task.issue_url, placeholder: 'Link to issue (optional)'
        end

        div class: 'input' do
          select :complexity, complexity_options_list
        end

        div class: 'input' do
          select :time_estimate, time_estimate_options_list
        end

        div class: 'input task-body', id: "task-body" do
          div class: 'pure-menu pure-menu-horizontal pure-menu-scrollable is-center task-body__actions' do

            div class: 'pure-menu pure-menu-horizontal pure-menu-scrollable task-body__menu' do
              ul class: 'pure-menu-list' do
                li class: 'pure-menu-item' do
                  button 'Write', type: :button, 'v-on:click' => 'displayForm',
                    class: 'btn btn-default pure-menu-link', 'v-bind:class' => "{ 'btn-default-selected': write }"
                end

                li class: 'pure-menu-item' do
                  button 'Preview', type: :button, 'v-on:click' => 'displayPreview',
                    class: 'btn btn-default pure-menu-link', 'v-bind:class' => "{ 'btn-default-selected': preview }"
                end
              end
            end

            div class: 'pure-u-1 task-body__write', 'v-if' => "write" do
              text_area :md_body, task.md_body, placeholder: 'Body', 'v-model' => "taskBody"
              div(class: 'task-form__body-tip') do
                em '* you can use markdown syntax'
              end
            end

            div class: 'pure-u-1 task-body__preview', 'v-if' => "preview" do
              div id: "floatingCirclesG", 'v-if' => "loadPreview" do
                div class: "f_circleG", id: "frotateG_01"
                div class: "f_circleG", id: "frotateG_02"
                div class: "f_circleG", id: "frotateG_03"
                div class: "f_circleG", id: "frotateG_04"
                div class: "f_circleG", id: "frotateG_05"
                div class: "f_circleG", id: "frotateG_06"
                div class: "f_circleG", id: "frotateG_07"
                div class: "f_circleG", id: "frotateG_08"
              end
              div class: 'task-body__preview', id: 'previewed-text', 'v-html' => "rawBody" do
              end
            end
          end
        end

        div class: 'input' do
          select :lang, langs_list
        end

        if current_user.registred?
          div class: 'input agree-checkbox' do
            check_box :aprove, id: 'agreement-checkbox'
            label 'I agree to be a mentor to the developer that’s willing to work on my project’s task', for: 'agreement-checkbox'
          end
        end

        a 'Back', href: routes.tasks_path, class: 'btn btn-back'

        if current_user.registred?
          submit('Create', class: 'pure-button pure-button-disabled pure-button-primary', id: 'new-task-submit')
        else
          span('Create', class: 'pure-button pure-button-disabled')
        end
      end
    end

    def task_form
      Form.new(:task, routes.tasks_path, {}, { method: :post })
    end

    def tasks_active?
      true
    end
  end
end
