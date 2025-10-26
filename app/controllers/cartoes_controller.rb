class CartoesController < ApplicationController
  before_action :set_cartao, only: %i[show edit update destroy]

  add_breadcrumb Cartao.model_name.human, :cartoes_path
  add_breadcrumb I18n.t("breadcrumb.show"), :cartao_path, only: %i[show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_cartao_path, only: %i[new create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_cartao_path, only: %i[edit update]

  respond_to :html

  def index
    @q = Cartao.ransack(params[:q])
    @cartoes = @q.result.page(params[:page]).per(params[:limit])
  end

  def show; end
  def new; @cartao = Cartao.new; end
  def edit; end

  def create
    @cartao = Cartao.new(cartao_params)
    if @cartao.save
      redirect_to @cartao, notice: t("messages.create.notice")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @cartao.update(cartao_params)
      redirect_to @cartao, notice: t("messages.update.notice")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cartao.destroy!
    redirect_to cartoes_path, status: :see_other, notice: t("messages.destroy.notice")
  end

  private

  def set_cartao
    @cartao = Cartao.find(params[:id])
  end

  def cartao_params
    params.require(:cartao).permit(
      :apelido, :emissor, :bandeira, :final_cartao,
      :fechamento_dia, :vencimento_dia, :limite_total,
      :ativo, :timezone
    )
  end
end
