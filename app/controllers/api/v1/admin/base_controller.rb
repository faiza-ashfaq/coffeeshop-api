# frozen_string_literal: true

module Api
  module V1
    module Admin
      class BaseController < ApiController
        before_action :check_admin

        private

        def check_admin
          return if current_user.admin?

          render json: { errors: I18n.t('admin.not_an_admin') }, status: :unauthorized
        end
      end
    end
  end
end
