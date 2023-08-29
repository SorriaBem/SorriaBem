class CreateDentists < ActiveRecord::Migration[7.0]
  def change
    create_table :dentists do |t|
      t.string :nome
      t.string :cpf
      t.string :email
      t.string :especialidade
      t.string :cro
      t.time :inicio_horario_atendimento
      t.time :termino_horario_atendimento

      t.timestamps
    end
  end
end
