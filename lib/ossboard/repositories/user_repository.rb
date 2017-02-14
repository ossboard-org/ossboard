class UserRepository < Hanami::Repository
  associations do
    has_many :tasks
    has_many :accounts
    has_many :repos
    has_many :points
  end

  def admins
    users.where(admin: true).as(User).to_a
  end

  def all_from_date(from)
    all_from_date_request(from).as(User).to_a
  end

  def count_all_from_date(from)
    result = all_from_date_request(from)
      .select{ [count(:id), Sequel.lit('created_at::date')] }
      .group(Sequel.lit('created_at::date'))
      .order(nil)
      .to_a

    result.each_with_object({}) {  |users, hsh| hsh[users.created_at] = users.count }
  end

  def find_by_login(login)
    users.where(login: login).as(User).first
  end

  def find_by_login_with_tasks(login)
    aggregate(:tasks).where(login: login).as(User).first
  end

  def find_with_tasks(id)
    aggregate(:tasks).where(id: id).as(User).one
  end

  def all_with_points_and_tasks
    aggregate(:points, :tasks).as(User).to_a
  end

  private

  def all_from_date_request(from)
    users.where("created_at > '#{from}'").where("created_at < '#{Time.now}'")
  end
end
