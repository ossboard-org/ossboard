Hanami::Model.migration do
  change do
    add_column :tasks, :lang, String, default: 'undefined'
  end
end
