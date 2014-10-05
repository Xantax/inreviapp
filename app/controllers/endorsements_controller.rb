class EndorsementsController < ApplicationController
  before_action :set_endorsement, only: [:edit, :update, :destroy, :approving]
  before_action :must_be_completely_verified, except: [:index]
  before_action :require_permission, only: [:destroy, :edit, :update]
  before_filter :record_last_endorsements_visit, only: [:index]
  before_filter :not_himself, only: [:new, :create]

  def index
    @endorsements = Endorsement.order('created_at DESC').where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @user = User.find(params[:user_id])
    @endorsement = Endorsement.new
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def create    
    @user = User.find(params[:user_id])
    @endorsement = @user.endorsements.create(endorsement_params)

      if @endorsement.save        
        @endorsement.create_activity :create, owner: current_user                
        User.increment_counter(:credit, current_user)
        User.increment_counter(:credit, @user.id)        
        redirect_to root_url
      else
        render :new
      end
  end

  def update
      if @endorsement.update(endorsement_params)
        redirect_to @endorsement
      else
        render :edit
      end
  end

  def destroy
    @endorsement.destroy
    redirect_to endorsements_url
  end
  
  def approving
    @endorsement.toggle!(:approved)
    redirect_to user_endorsements_path(current_user)
  end

  private

    def set_endorsement
      @endorsement = Endorsement.find(params[:id])
    end

    def endorsement_params
      params.require(:endorsement).permit(:body, :writer_id, :user_id, :approved)
    end
  
    def record_last_endorsements_visit
      if current_user
        current_user.touch :last_visited_endorse_at
      end
    end
  
    def require_permission
      if current_user != Conversation.find(params[:id]).user
        redirect_to root_path
      end
    end
  
    def not_himself
      @user = User.find(params[:user_id])
      if current_user.id == @user.id
        redirect_to root_path
      end
    end
end
