class Task < Hanami::Entity
  VALID_STATUSES = {
    in_progress: 'in progress',
    assigned: 'assigned',
    closed: 'closed',
    done: 'done'
  }.freeze

  VALID_LANGUAGES = {
    unknown: 'unknown',
    ruby: 'ruby',
    js: 'javascript',
    java: 'java',
    python: 'python',
    go: 'go',
    haskell: 'haskell',
    lua: 'lua',
    scala: 'scala',
    elixir: 'elixir',
    rust: 'rust',
    clojure: 'clojure',
    php: 'php'
  }.freeze

  # TODO: Tests
  def author
    UserRepository.new.find(user_id)
  end
end
