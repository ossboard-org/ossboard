Hanami::Model.migration do
  change do
    create_table :accounts do
      primary_key :id
      foreign_key :user_id, :users, null: false

      column :uid,                 String
      column :token,               String
      column :extended_privileges, TrueClass, default: false
    end
  end
end
