class UsersController < ApplicationController

    before_action :authorize

    def create
        user = User.create(user_params)
        if user.valid?
            render json: user, status: :created
        else
            render json{error: user.errors.full_message}, status: :unprocessable_entity
        end
    end


    def show
        user = User.find(params[:id])
        render json: user
    end

    private 

    def user_params
        params.permit(:name, :password_digest)
    end

    def authorize
        return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    end

end
