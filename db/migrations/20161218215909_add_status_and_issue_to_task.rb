Hanami::Model.migration do
  change do
    add_column :tasks, :issue_url, String
    add_column :tasks, :status, String
  end
end
