module Api
  module V1
    class ApiController < ActionController::API
      include ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      include ExceptionHandler
      include Localizable
      include Pagy::Backend
      include Pundit::Authorization

      before_action :authenticate_user!

      def current_cart
        @current_cart ||= Cart.find_or_create_by(user: current_user)
      end
    end
  end
end
