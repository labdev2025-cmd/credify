class PessoasController < ApplicationController
  before_action :set_pessoa, only: %i[show edit update destroy]

  add_breadcrumb Pessoa.model_name.human, :pessoas_path
  add_breadcrumb I18n.t("breadcrumb.show"), :pessoa_path, only: %i[show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_pessoa_path, only: %i[new create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_pessoa_path, only: %i[edit update]

  respond_to :html

  def index
    @q = Pessoa.ransack(params[:q])
    @pessoas = @q.result.page(params[:page]).per(params[:limit])
  end

  def show; end

  def new
    @pessoa = Pessoa.new
  end

  def edit; end

  def create
    @pessoa = Pessoa.new(pessoa_params)

    if @pessoa.save
      redirect_to @pessoa, notice: t("messages.create.notice")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @pessoa.update(pessoa_params)
      redirect_to @pessoa, notice: t("messages.update.notice")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pessoa.destroy!
    redirect_to pessoas_path, status: :see_other, notice: t("messages.destroy.notice")
  end

  private

  def set_pessoa
    @pessoa = Pessoa.find(params[:id])
  end

  def pessoa_params
    params.require(:pessoa).permit(:nome, :apelido, :documento, :email, :telefone, :ativo)
  end
end
