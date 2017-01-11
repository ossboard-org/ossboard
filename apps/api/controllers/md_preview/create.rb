module Api::Controllers::MdPreview
  class Create
    include Api::Action

    params do
      required(:md_text).filled(:str?)
    end

    def call(params)
      self.body = JSON.generate(text: text)
    end

  private

    EMPTY_STRING = ''.freeze

    def text
      params.valid? ? Markdown.parse(params[:md_text]) : EMPTY_STRING
    end
  end
end
