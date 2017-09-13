require 'hanami/interactor'

module Interactors
  module Users
    class Update
      include Hanami::Interactor

      expose :user

      def initialize(params_valid, params)
        @params = params
        @params_valid = params_valid
        @user = repo.find(@params[:id])
      end

      def call
        return error('No user found') unless @user
        return error('Unprocessable entity') unless @params_valid

        prepare_user_params
        repo.update(@user.id, @params[:user])
      end

    private

      def repo
        UserRepository.new()
      end

      def prepare_user_params

        @params[:user][:admin] = @params[:user][:admin] == '1'
      end
    end
  end
end
