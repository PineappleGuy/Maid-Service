class ClientsController < ApplicationController
    before_action :get_client, only: [:show, :edit, :update]
    before_action :authenticate

    def new
        @client = Client.new
    end

    def create
        @client = Client.new(client_params)
        if @client.save
            @account = Account.find(session[:account_id])
            @account.accountable = @client
            if @account.save
                redirect_to client_path(@client)
            end
        else
            render :new
        end
    end

    def show
        authorize(@client)
        @residences = Residence.where(["client_id = :client_id", {client_id: params[:id]}])
    end

    def edit
        authorize(@client)
    end

    def patch
    end
    
    def update
        authorize(@client)
        if @client.update(client_params)
            redirect_to client_path(@client)
        else
            render :edit
        end
    end

    private

    def client_params
        params.require(:client).permit(:first_name, :last_name, :city, :state)
    end

    def get_client
        @client = Client.find(current_user.id)
    end
    
end