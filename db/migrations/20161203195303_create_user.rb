Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :name,       String
      column :uuid,       String
      column :login,      String
      column :email,      String
      column :avatar_url, String
      column :bio,        String, text: true
      column :admin,      TrueClass, default: false
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
end
