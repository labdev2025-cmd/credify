class CategoriasController < ApplicationController
  before_action :set_categoria, only: %i[show edit update destroy]

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
  def new; @categoria = Categoria.new; end
  def edit; end

  def create
    @categoria = Categoria.new(categoria_params)
    if @categoria.save
      redirect_to @categoria, notice: t("messages.create.notice")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @categoria.update(categoria_params)
      redirect_to @categoria, notice: t("messages.update.notice")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @categoria.destroy!
    redirect_to categorias_path, status: :see_other, notice: t("messages.destroy.notice")
  end

  private

  def set_categoria
    @categoria = Categoria.find(params[:id])
  end

  def categoria_params
    params.require(:categoria).permit(:nome, :tipo)
  end
end
