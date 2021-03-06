class MaidsController < ApplicationController
    before_action :get_maid, only: [:show, :edit, :update]
    before_action :authenticate

    def new
        @maid = Maid.new
    end

    def create
        @maid = Maid.new(maid_params)
        if @maid.save
            @account = Account.find(session[:account_id])
            @account.accountable = @maid
            if @account.save
                redirect_to maid_path(@maid)
            end
        else
            render :new
        end
    end

    def show 
        authorize(@maid)
        @schedules = Schedule.where(["maid_id = :maid_id", {maid_id: current_user.id}])
    end

    def edit
        authorize(@maid)
    end

    def update
        authorize(@maid)
        if @maid.update(maid_params)
            redirect_to maid_path(@maid)
        else
            render :edit
        end
    end
          
    private 
    
    def maid_params
        params.require(:maid).permit(:first_name, :last_name, :city, :state, :experience, :overall_rating, :number_of_ratings)
    end

    def get_maid
        @maid = Maid.find(current_user.id)
    end

end
