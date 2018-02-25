class ProfileController < ApplicationController
    before_action :authorize
    def index
        @user= current_user
        @snaps = current_user.snaps.all
        puts @snaps
        @user_snap = current_user.snaps.new
        @total_snap = current_user.snaps.count
    end
    def updateProfile
        @user = current_user
        @user.update(user_params)
        redirect_to profile_path
    end
    def uploadSnap
        @user_snap = current_user.snaps.new
        @user_snap.image = snaps_params[:image]
        @user_snap.save
        redirect_to profile_path
    end
  
    def deleteSnap
        puts params[:id]
        current_user.snaps.where(id: params[:id]).delete_all
        redirect_to profile_path
    end
    private
    def user_params
        params.require(:user).permit(:image, :first_name, :last_name, :email, :phone, :user_name)
    end
    def snaps_params
        params.require(:snap).permit(:image, :user_id)
    end
end
