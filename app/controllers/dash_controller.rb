class DashController < ApplicationController
    before_action :authorize
    def index
        @user = current_user
        @snap_upload = current_user.snaps.new
        @follow_count = current_user.follows.count
        @follower_count = current_user.followers.count
        @follow = current_user.follows.all
        @folloe_user = current_user.follows
        @follower_user = current_user.followers
        @all_snap = Array.new
        @total_snaps = current_user.snaps.count
        current_user.feeds.delete_all
        if @follow.blank?

        else
            @follow.each do |f|
                @curr_user =  User.find(f.follow_id) 
                @curr_snap = Snap.where(user_id: f.follow_id)
                @curr_snap.each do |c_s|
                    data = current_user.feeds.new(image: c_s.image, time: c_s.created_at, user_name: @curr_user.user_name, subs_user_id: @curr_user.id)
                    data.save
                    @all_snap.push << data
                end
            end
        end
        puts @all_snap.length
        if current_user.snaps.blank?
        else
            current_user.snaps.each do |c_u_s|
                puts c_u_s.created_at
                if c_u_s.created_at != nil 
                    data = current_user.feeds.new(image: c_u_s.image, time: c_u_s.created_at, user_name: current_user.user_name)
                    data.save
                    @all_snap.push << data
                end    
            end
        end    
        @feeds = current_user.feeds.order(time: :desc)

    end

    def updateProfile
        @user = current_user
        @user.update_attribute(user_params)
        redirect_to profile_path
    end
    def searchPage 
        puts params[:email]
        if params[:email].blank?
            flash[:notice] = " Bummer! Please enter the email or username"
            redirect_to dash_path
        else
            if params[:email].include?("@")
                @search_user  = User.find_by(email: params[:email])
                if @search_user == current_user
                    redirect_to profile_path
                elsif @search_user
                   @follow_user =  @search_user.followers.find_by(follower_id: current_user.id)
                    if @follow_user
                        @search_user
                        @follows_count = @search_user.follows.count
                        @follower_count = @search_user.followers.count
                        @snaps = @search_user.snaps.order(created_at: :desc)
                        @snaps_count = @search_user.snaps.count
                    else
                        @search_user
                        @follows_count = @search_user.follows.count
                        @follower_count = @search_user.followers.count
                        @follow_user
                    end
                else
                    flash[:notice] = " Bummer! No user found"
                    redirect_to dash_path
                end
            else
                @search_user = User.find_by(user_name: params[:email])
                if @search_user == current_user
                    redirect_to profile_path
                elsif @search_user
                   @follow_user =  @search_user.followers.find_by(follower_id: current_user.id)
                    if @follow_user
                        @search_user
                        @follows_count = @search_user.follows.count
                        @follower_count = @search_user.followers.count
                        @snaps = @search_user.snaps.order(created_at: :desc)
                        @snaps_count = @search_user.snaps.count
                    else
                        @search_user
                        @follows_count = @search_user.follows.count
                        @follower_count = @search_user.followers.count
                        @follow_user
                    end
                else
                    flash[:notice] = "Bummer! No user found"
                    redirect_to dash_path
                end
            end
        end
    end
    def follow
       @user_id =  params[:user_id].to_i
       @search_user_id  =  params[:search_user_id].to_i
       puts @search_user_id
       @user_follow = current_user.follows.new
       @user_follow.follow_id = @search_user_id 
       @user_follow.save
       @SearchUser = User.find_by(id: @search_user_id)
        if @SearchUser
            @follower = @SearchUser.followers.new
            @follower.follower_id = @user_id
            @follower.save
        end
        redirect_to dash_path
    end
    def unfollow
      puts   params[:user_id]
      puts   params[:subscribe_user_id]
      @user = User.find_by(id: params[:user_id])
      current_user.follows.where(follow_id: params[:subscribe_user_id]).delete_all
      @search_user = User.find_by(id: params[:subscribe_user_id])
      @follower = @search_user.followers.where(follower_id: params[:user_id]).delete_all
      redirect_to dash_path
    end

    def upload_snap
        @snap = current_user.snaps.new(snap_params)
        if @snap.save
            redirect_to dash_path
        else
            redirect_to dash_path
        end
    end
    def followProfile
       puts  params[:id]
        if params[:id] == current_user.id
            redirect_to profile_path
        else
            @curr_check_follow = current_user.follows.find_by(follow_id: params[:id])
            @curr_check_follower = current_user.followers.find_by(follower_id: params[:id])
            if @curr_check_follow ||  @curr_check_follower
                @follow_user = User.find( params[:id])
                if @follow_user
                  puts   @follow_user
                    @snaps = @follow_user.snaps.order(created_at: :desc)
                    @follows_count = @follow_user.follows.count
                    @follower_count = @follow_user.followers.count
                    @snap_count = @follow_user.snaps.count
                end
            end   
        end     

    end
  
    private
    def user_params
        params.require(:user).permit(:image)
    end
    def snap_params
        params.require(:snap).permit(:image, :user_id)
    end
end
