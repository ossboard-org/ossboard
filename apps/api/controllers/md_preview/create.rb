module Api::Controllers::MdPreview
  class Create
    include Api::Action
    include Hanami::Serializer::Action
    include Import['core.markdown_parser']

    params do
      required(:md_text).filled(:str?)
    end

    # TODO: move to operations
    def call(params)
      send_json(text: text)
    end

  private

    EMPTY_STRING = ''.freeze

    def text
      params.valid? ? markdown_parser.call(params[:md_text]) : EMPTY_STRING
    end
  end
end
