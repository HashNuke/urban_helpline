class Admin::UsersController < AdminController

  before_filter :find_user, only: [:edit, :update, :destroy]

  #NOTE skip filter to check if the user is editing his own credentials
  skip_before_filter :authorize!, only: [:edit, :update]
  before_filter :allow_if_owned_by_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(permitted_params.user)

    respond_to do |format|
      format.html {
        if @user.save
          redirect_to admin_users_path
        else
          render :new
        end
      }
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(permitted_params.user)
        format.html {
          if current_user.id == @user.id
            redirect_to admin_path, notice: 'User details were successfully updated.'
          else
            redirect_to admin_users_path, notice: 'User details were successfully updated.'
          end
        }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "The user has been removed"
    else
      flash[:notice] = "There was a problem removing that user"
    end

    redirect_to admin_users_path
  end

  private

  def allow_if_owned_by_user
    #NOTE allow editing if user editing own credentials else verify permissions
    authorize! if @user.id != current_user.id
  end

  def find_user
    @user = User.find params[:id]
  end
end
