Hanami::Model.migration do
  change do
    add_column :tasks, :complexity, String, default: 'easy'
  end
end
