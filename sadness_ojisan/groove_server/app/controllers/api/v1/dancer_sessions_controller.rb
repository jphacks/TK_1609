module Api
  module V1
    class DancerSessionsController < ApplicationBaseController
      skip_before_filter :require_valid_token, only: [:create, :destroy]

      def create
        logger.debug("[DANCER_SESSION_CTR]: createメソッドが呼ばれた.")
        if @dancer = login(login_dancer[:email], login_dancer[:password])
          logger.debug("[DANCER_SESSION_CTR]: @dancer = " + @dancer.attributes.to_s)
          api_key = @dancer.activate #activateは, dancerモデルがもっているmethod. apiキーを返す(Collection型)
          @access_token = api_key.access_token
          session[:HTTP_ACCESS_TOKEN] = @access_token
          logger.debug("[DANCER_SESSION_CTR]: session[:HTTP_ACCESS_TOKEN] = " + session[:HTTP_ACCESS_TOKEN].to_s)
        else
          logger.debug("[DANCER_SESSION_CTR]: login(login_dancer[:email], login_dancer[:password])がエラーです. ")
          respond_to do |format|
            format.json { render nothing: true, status: :not_found }
          end
        end
      end


      def destroy
        logger.debug("[DANCER_SESSION_CTR]: destroyメソッドが呼ばれた.")
        access_token = request.headers[:HTTP_ACCESS_TOKEN]
        api_key = ApiKey.find_by_access_token(access_token)
        if api_key
          dancer = Dancer.find(api_key.dancer_id)
          dancer.inactivate
          respond_to do |format|
            format.json { render nothing: true, status: :ok }
          end
        end
      end

      private
        def login_dancer
          logger.debug("[DANCER_SESSION_CTR]: login_dancerメソッドが呼ばれた.")
          params[:dancer]
        end
    end
  end
end
