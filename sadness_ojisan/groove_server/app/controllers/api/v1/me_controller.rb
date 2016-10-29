module Api
  module V1
    class MeController < ApplicationBaseControllerurl
      def show
        if session[:HTTP_ACCESS_TOKEN] == nil then
          if request.headers[:HTTP_ACCESS_TOKEN] == nil then
            access_token = params[:headers][:HTTP_ACCESS_TOKEN]
          else
            access_token = request.headers[:HTTP_ACCESS_TOKEN]
          end
        else
          access_token = session[:HTTP_ACCESS_TOKEN]
        end
        logger.debug("[API_ME_CTR] session[:HTTP_ACCESS_TOKEN]: " + session[:HTTP_ACCESS_TOKEN].to_s)
        api_key = ApiKey.find_by_access_token(access_token)
        if api_key
          @dancer = Dancer.find(api_key.dancer_id)
        end
        @rank_records = Record.all

        # フォロー
        logger.debug("[API_ME_CTR] Follow.all: " + Follow.all.to_s)
        follow_id = Follow.where(dancer_id: @dancer.id).pluck(:follow_id)
        logger.debug("[API_ME_CTR] follow_id: " + follow_id.to_s)
        @follower_records = Record.where(dancer_id: follow_id)
        logger.debug("[API_ME_CTR] @follower_records: " + @follower_records.to_s)

        # ふぁぼ
        logger.debug("[API_ME_CTR] Favorite.all: " + Favorite.all.to_s)
        favorite_id = Favorite.where(dancer_id: @dancer.id).pluck(:record_id)
        logger.debug("[API_ME_CTR] favorite_id: " + favorite_id.to_s)
        @favorite_records = Record.where(dancer_id: favorite_id)
        logger.debug("[API_ME_CTR] @favorite_records: " + @favorite_records.to_s)
      end
    end
  end
end
