Hanami::Utils.require!("#{__dir__}/ossboard")

Hanami::Mailer.configure do
  delivery do
    development :test
    test        :test
  end
end.load!
