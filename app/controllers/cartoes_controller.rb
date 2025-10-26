class CartoesController < ApplicationController
  before_action :set_cartao, only: %i[ show edit update destroy ]

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

  def new
    @cartao = Cartao.new
  end

  def edit; end

  def create
    @cartao = Cartao.new(cartao_params)

    respond_to do |format|
      if @cartao.save
        format.html { redirect_to @cartao, notice: t("messages.create.notice") }
        format.json { render :show, status: :created, location: @cartao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cartao.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cartao.update(cartao_params)
        format.html { redirect_to @cartao, notice: t("messages.update.notice") }
        format.json { render :show, status: :ok, location: @cartao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cartao.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cartao.destroy!

    respond_to do |format|
      format.html { redirect_to cartoes_path, status: :see_other, notice: t("messages.destroy.notice") }
      format.json { head :no_content }
    end
  end

  private

  def set_cartao
    @cartao = Cartao.find(params.expect(:id))
  end

  def cartao_params
    params.expect(cartao: [ :apelido, :emissor, :bandeira, :final_cartao, :fechamento_dia, :vencimento_dia, :limite_total, :ativo, :timezone ])
  end
end
