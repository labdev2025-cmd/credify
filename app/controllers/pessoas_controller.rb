class PessoasController < ApplicationController
  before_action :set_pessoa, only: %i[ show edit update destroy ]

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

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to @pessoa, notice: t("messages.create.notice") }
        format.json { render :show, status: :created, location: @pessoa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        format.html { redirect_to @pessoa, notice: t("messages.update.notice") }
        format.json { render :show, status: :ok, location: @pessoa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pessoa.destroy!

    respond_to do |format|
      format.html { redirect_to pessoas_path, status: :see_other, notice: t("messages.destroy.notice") }
      format.json { head :no_content }
    end
  end

  private

  def set_pessoa
    @pessoa = Pessoa.find(params.expect(:id))
  end

  def pessoa_params
    params.expect(pessoa: [ :nome, :apelido, :documento, :email, :telefone, :ativo ])
  end
end
