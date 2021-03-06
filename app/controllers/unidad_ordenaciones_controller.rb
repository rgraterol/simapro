class UnidadOrdenacionesController < ApplicationController
  before_action :set_unidad_ordenacion, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @unidad_ordenaciones = UnidadOrdenacion.unidades_empresa(current_user.empresa_forestal_id)
    respond_with(@unidad_ordenaciones)
  end

  def show
    respond_with(@unidad_ordenacion)
  end

  def new
    @unidad_ordenacion = UnidadOrdenacion.new
    @reserva_forestales = ReservaForestal.where(empresa_forestal_id: current_user.empresa_forestal_id)
    respond_with(@unidad_ordenacion)
  end

  def edit
    @reserva_forestales = ReservaForestal.where(empresa_forestal_id: current_user.empresa_forestal_id)
  end

  def create
    @reserva_forestales = ReservaForestal.where(empresa_forestal_id: current_user.empresa_forestal_id)
    @unidad_ordenacion = UnidadOrdenacion.new(unidad_ordenacion_params)
    @unidad_ordenacion.save
    respond_with(@unidad_ordenacion)
  end

  def update
    @reserva_forestales = ReservaForestal.where(empresa_forestal_id: current_user.empresa_forestal_id)
    @unidad_ordenacion.update(unidad_ordenacion_params)
    respond_with(@unidad_ordenacion)
  end

  def destroy
    if @unidad_ordenacion.safe_to_delete
      @unidad_ordenacion.destroy
      respond_with(@unidad_ordenacion)
    end
  end

  private
    def set_unidad_ordenacion
      @unidad_ordenacion = UnidadOrdenacion.find(params[:id])
    end

    def unidad_ordenacion_params
      params.require(:unidad_ordenacion).permit(:reserva_forestal_id,
                                                :codigo,
                                                :nro_contrato,
                                                :fecha_otorgamiento,
                                                :fecha_vencimiento,
                                                :area,
                                                :descripcion,
                                                municipio_ids:[],
                                                documentos_attributes:[:id,
                                                                       :documentos_requisitos_por_vista_id,
                                                                       :doc])
    end
end
