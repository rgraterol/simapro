# == Schema Information
#
# Table name: unidad_ordenaciones
#
#  id                  :integer          not null, primary key
#  reserva_forestal_id :integer
#  codigo              :string(3)
#  nro_contrato        :string(16)
#  fecha_otorgacion    :date
#  fecha_vence         :date
#  area                :decimal(12, 2)
#  descripcion         :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_unidad_ordenaciones_on_codigo               (codigo) UNIQUE
#  index_unidad_ordenaciones_on_reserva_forestal_id  (reserva_forestal_id)
#

require 'test_helper'

class UnidadOrdenacionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
