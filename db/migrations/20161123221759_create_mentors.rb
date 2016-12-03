Hanami::Model.migration do
  change do
    create_table :mentors do
      primary_key :id

      column :name,       String
      column :github,     String
      column :contacts,   String, text: true
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
end
