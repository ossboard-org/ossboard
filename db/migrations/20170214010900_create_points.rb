Hanami::Model.migration do
  change do
    create_table :points do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade

      column :maintainer, Integer, default: 0
      column :developer,  Integer, default: 0
    end
  end
end
