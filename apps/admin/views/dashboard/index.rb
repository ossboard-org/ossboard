module Admin::Views::Dashboard
  class Index
    include Admin::View

    def dashboard_active?
      true
    end
  end
end
