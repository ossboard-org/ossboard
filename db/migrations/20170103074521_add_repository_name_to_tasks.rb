Hanami::Model.migration do
  change do
    add_column :tasks, :repository_name, String
  end
end
