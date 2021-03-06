class ParcelaInventario < ActiveRecord::Base
  belongs_to :parcela_manejo

  has_many :medicion_parcela_inventarios
  has_many :arbol_inventario_estaticos, through: :medicion_parcela_inventarios
  accepts_nested_attributes_for :medicion_parcela_inventarios, :arbol_inventario_estaticos , reject_if: :all_blank, allow_destroy: true

  validates :parcela_manejo_id, presence: true, uniqueness: true

  def self.create_or_update(parcela_manejo_id, params)
    parcela_manejo = ParcelaManejo.find_by(id: parcela_manejo_id)
    parcela_manejo.parcela_inventario.present? ?
        parcela_manejo.parcela_inventario.update(params) :
        parcela_manejo.create_parcela_inventario(params)
    return parcela_manejo.parcela_inventario
  end

  def self.get_parcelas_tpi(unidad_manejo_id, tipo_parcela_inventario_id)
    UnidadManejo.find(unidad_manejo_id).parcela_inventarios.joins(:medicion_parcela_inventarios).where(medicion_parcela_inventarios: { tipo_parcela_inventario_id: tipo_parcela_inventario_id })
  end

  def create_or_update_medicion_inventario(params, tipo_parcela_inventario_id)
    medicion_parcela = self.medicion_parcela_inventarios.find_by(tipo_parcela_inventario_id: tipo_parcela_inventario_id)
    medicion_parcela.nil? ?
      (medicion_parcela = self.medicion_parcela_inventarios.create(params.merge(tipo_parcela_inventario_id: tipo_parcela_inventario_id))) :
      medicion_parcela.update(params)
    return medicion_parcela
  end

  def self.por_unidad_manejo(unidad_manejo_id)
    return UnidadManejo.find(unidad_manejo_id).parcela_inventarios
  end

end
