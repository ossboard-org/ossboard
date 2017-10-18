module Api::Controllers::Analytics
  class Index
    include Api::Action
    include Hanami::Serializer::Action
    include Import['services.analytic_reporter']

    def call(params)
      send_json(analytic_reporter.call)
    end
  end
end
