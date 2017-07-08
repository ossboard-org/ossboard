OSSBoard::Application.finalize(:markdown) do |container|
  container.register(:markdown, OSSBoard::Markdown.new)
end
