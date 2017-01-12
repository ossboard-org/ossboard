Hanami::Model.migration do
  change do
    add_column :tasks, :time_estimate, String, default: 'few days'
  end
end
