Hanami::Model.migration do
  change do
    add_column :tasks, :md_body, String, text: true
  end
end
