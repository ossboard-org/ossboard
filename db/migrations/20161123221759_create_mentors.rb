Hanami::Model.migration do
  change do
    create_table :mentors do
      primary_key :id
      column :name,       String
      column :uid,        String
      column :login,      String
      column :email,      String
      column :avatar_url, String
      column :bio,        String, text: true
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
end
