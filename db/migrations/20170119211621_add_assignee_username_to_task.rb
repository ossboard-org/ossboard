Hanami::Model.migration do
  change do
    add_column :tasks, :assignee_username, String
  end
end
