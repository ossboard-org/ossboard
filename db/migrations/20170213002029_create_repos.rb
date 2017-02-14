Hanami::Model.migration do
  change do
    create_table :repos do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade

      column :name,              String
      column :url,               String
      column :active,            TrueClass, default: false
    end
  end
end
