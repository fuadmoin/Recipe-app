class UsersController < ApplicationController
    before_action :authenticate_user!, only: %i[index]

    def index
        @users = User.all
    end
end