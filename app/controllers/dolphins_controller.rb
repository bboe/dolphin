# frozen_string_literal: true

class DolphinsController < AuthenticatedController
  before_action :check_params, only: :create

  def index
    load_index_variables(params: params)
  end

  def create
    from = User.find_by(email: domained_email(params[:dolphin][:from]))
    from ||= User.find_by(nickname: params[:dolphin][:from])

    @dolphin = Dolphin.new(from: from, to: current_user, source: ip_address)
    if @dolphin.save
      redirect_to(root_path,
                  notice: "You were dolphined by #{from.name}! To lock your macbook press ctrl+shift+eject.")
      return
    end

    flash.now[:alert] = @dolphin.errors[:from].first
    @dolphin.from = nil
    load_index_variables
    render :index, status: :bad_request
  end

  private

  def check_params
    return unless params[:dolphin][:from].nil?
    load_index_variables
    render :index, status: :unprocessable_entity
  end

  def domained_email(email)
    return email if email.include?('@') || Rails.configuration.google_client_domain_list.length != 1
    domain = Rails.configuration.google_client_domain_list.first
    "#{email}@#{domain}"
  end

  def load_index_variables(params: {})
    query = Dolphin.includes(:from, :to).order('created_at desc')

    if params[:filter]
      if (user = User.find_by(email: domained_email(params[:filter])))
        query = query.where('from_id=? or to_id=?', *[user.id] * 2)
      else
        flash.now[:alert] = "#{params[:filter]} does not match a valid email"
        params[:filter] = nil
      end
    end

    @dolphins = query.paginate(page: params[:page], per_page: 4)
    @top_froms = Dolphin.top(by: :from, limit: 8)
    @top_tos = Dolphin.top(by: :to, limit: 8)
  end
end
