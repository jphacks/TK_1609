module Api
  module V1
    class ApplicationBaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :require_valid_token
      private
        def require_valid_token
          logger.debug("[ApplicationBaseController]: request.headers[:HTTP_ACCESS_TOKEN]: " + request.headers[:HTTP_ACCESS_TOKEN].to_s + "\n")
            if session[:HTTP_ACCESS_TOKEN] == nil then # sessionに残っているかをチェックする.
            if request.headers[:HTTP_ACCESS_TOKEN] == nil then
              access_token = params[:headers][:HTTP_ACCESS_TOKEN]
            else
              access_token = request.headers[:HTTP_ACCESS_TOKEN]
            end
          else
            access_token = session[:HTTP_ACCESS_TOKEN]
          end
          logger.debug("[ApplicationBaseController] access_token: " + access_token.to_s + "\n")
          if !Dancer.login?(access_token)
            logger.debug("[ApplicationBaseController]: TOKEN認証の結果LOGINに失敗しました. ")
            respond_to do |format|
              format.json { render nothing: true, status: :unauthorized }
            end
          end
        end
    end
  end
end
