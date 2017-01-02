class UserRepository < Hanami::Repository
  associations do
    has_many :tasks
  end

  def admins
    users.where(admin: true).as(User).to_a
  end

  def find_by_login(login)
    users.where(login: login).as(User).first
  end

  def find_by_login_with_tasks(login)
    aggregate(:tasks).where(login: login).as(User).first
  end

  def find_by_uuid(uuid)
    users.where(uuid: uuid).as(User).first
  end

  def find_with_tasks(id)
    aggregate(:tasks).where(id: id).as(User).one
  end
end
