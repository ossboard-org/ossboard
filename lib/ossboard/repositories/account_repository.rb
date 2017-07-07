class AccountRepository < Hanami::Repository
  associations do
    belongs_to :user
  end

  def find_by_uid(uid)
    accounts.where(uid: uid).map_to(Account).one
  end
end
