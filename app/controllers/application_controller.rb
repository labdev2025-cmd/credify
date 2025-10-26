class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action if: -> { action_name == "index" } do
    if session[:controller].nil? || session[:controller][:name] != controller_path.to_sym
      session[:controller] = {}
      session[:controller][:name] = controller_path.to_sym
    end

    base = [5, 10, 15, 20, 25]
    params[:limit] = if params[:limit].to_i < 1
                       session[:controller][:limit].presence || ApplicationRecord.page.limit_value
                     elsif params[:limit].to_i <= base.last
                       params[:limit].to_i
                     else
                       base.last
                     end
    session[:controller][:limit] = params[:limit]
    @limites = [*base, params[:limit]].uniq.sort
    session[:controller][:limites] = @limites
    session[:controller][:url_att] = request.original_url

    session[:controller][:search] = params[:q] if params[:q].present?
    params[:q] = session[:controller][:search] if session[:controller][:search].present?
    params[:q] = session[:controller][:search] = nil if params[:clear].present?
  end

  add_breadcrumb "Início", :root_path

end
