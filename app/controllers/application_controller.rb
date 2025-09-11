class ApplicationController < ActionController::Base
  # 割愛

  # deviseコントローラーにストロングパラメータを追加する          
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # サインアップ時に許可するパラメータ
    devise_parameter_sanitizer.permit(
  :sign_up,
  keys: [:name, :image, :started_at, :role, :creator_type]
)

    # アカウント編集時に許可するパラメータ
    devise_parameter_sanitizer.permit(
  :account_update,
  keys: [:name, :profile, :profile_image, :x_url, :instagram_url,
         :facebook_url, :youtube_url, :started_at, :role, :creator_type]
)

  end

  def after_update_path_for(resource)
    tweets_path
  end
end