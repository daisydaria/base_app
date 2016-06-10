class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_current_user
  before_action :get_current_role
  before_action :check_app_auth
  include SessionHelper

  private

  
  
  def test_operator_rights
    unless is_operator?
      access_denied!
    end
  end

  def test_admin_rights
    unless is_admin?
      access_denied!
    end
  end

  def not_authenticated
    redirect_to login_path, alert: "Сначала войдите в систему!"
  end

  def load_current_user
    @current_user = current_user
  end

  def access_denied!
    render 'access_denied'
  end

  def check_app_auth
    return true
    render 'access_denied' unless @current_user.try(:is_admin?)
  end

  def get_current_role
    if @current_user.present?
	    ru_id = params['ru_id']
	    if ru_id.blank?
	      ru_id = session['ru_id']
	    end
	    if ru_id.present?
	      @current_role_user = @current_user.role_users.find{ |x| x.id == ru_id.to_i }
	    end
	    if @current_role_user.blank?
	      @current_role_user = @current_user.role_users.first
	    end
	    if @current_role_user.blank?
	      render 'access_denied' unless @current_user.try(:is_admin?)
	    else
	      session['ru_id'] = @current_role_user.id.to_s	
	    end
    end
  end
end
