module Api
  module V1
    class ApplicationBaseController < ApplicationController
      protect_from_forgery with: :null_session
  end
end
