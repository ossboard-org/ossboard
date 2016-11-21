Hanami::Model.migration do
  change do
    create_table :tasks do
      primary_key :id
      column :title,      String
      column :body,       String, text: true
      column :link,       String
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
end
