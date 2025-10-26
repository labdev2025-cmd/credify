class CategoriasController < ApplicationController
  before_action :set_categoria, only: %i[ show edit update destroy ]

  add_breadcrumb Categoria.model_name.human, :categorias_path
  add_breadcrumb I18n.t("breadcrumb.show"), :categoria_path, only: %i[show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_categoria_path, only: %i[new create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_categoria_path, only: %i[edit update]

  respond_to :html

  def index
    @q = Categoria.ransack(params[:q])
    @categorias = @q.result.page(params[:page]).per(params[:limit])
  end

  def show; end

  def new
    @categoria = Categoria.new
  end

  def edit; end

  def create
    @categoria = Categoria.new(categoria_params)

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to @categoria, notice: t("messages.create.notice") }
        format.json { render :show, status: :created, location: @categoria }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @categoria.update(categoria_params)
        format.html { redirect_to @categoria, notice: t("messages.update.notice") }
        format.json { render :show, status: :ok, location: @categoria }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @categoria.destroy!

    respond_to do |format|
      format.html { redirect_to categorias_path, status: :see_other, notice: t("messages.destroy.notice") }
      format.json { head :no_content }
    end
  end

  private

  def set_categoria
    @categoria = Categoria.find(params.expect(:id))
  end

  def categoria_params
    params.expect(categoria: [ :nome, :tipo ])
  end
end
