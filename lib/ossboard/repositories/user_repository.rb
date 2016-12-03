class UserRepository < Hanami::Repository
  def find_by_uuid(uuid)
    users.where(uuid: uuid).as(User).first
  end
end