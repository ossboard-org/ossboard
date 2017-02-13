class RepoRepository < Hanami::Repository
  associations do
    belongs_to :user
  end
end
