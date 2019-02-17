module Api::Controllers::Analytics
  class Index
    include Api::Action
    include Hanami::Serializer::Action
    include Import['services.analytic_reporter']

    # TODO: move to operations
    def call(params)
      send_json(analytic_reporter.call)
    end
  end
end
