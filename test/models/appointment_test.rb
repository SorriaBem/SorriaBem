require_relative "../test_helper"

class AppointmentTest < ActiveSupport::TestCase
  def setup
    @dentist = Dentist.create!(
      nome: "Dentist One",
      cpf: "12345668901",
      email: "dentist10@email.com",
      especialidade: "Odontologia Geral",
      cro: "65478",
      inicio_horario_atendimento: "08:00:00",
      termino_horario_atendimento: "17:00:00"
    )
    @patient = Patient.create!(
      full_name: "Johnny Bravo",
      email_address: "johnny_bravo2@email.com",
      cpf: "12345678900",
      phone_number: "40028922"
    )

    @appointment = Appointment.new(
      date: Date.tomorrow,
      time: "14:30:00",
      dentist: @dentist,
      patient: @patient
    )
  end

  test "should return no appointments for a future date with no appointments" do
    search_date = Date.tomorrow + 26

    @appointments = Appointment.where(date: search_date)

    # Não há consultas para daqui a 27 dias, então não haverá nenhuma consulta retornada
    assert_empty @appointments, "Should return no appointments for a future date with no appointments"
  end

  test "should return appointments for a valid date range" do
    appointment1 = Appointment.create(date: Date.tomorrow, time: "14:30:00", dentist: @dentist, patient: @patient)
    appointment2 = Appointment.create(date: Date.tomorrow + 1, time: "10:00:00", dentist: @dentist, patient: @patient)
    appointment3 = Appointment.create(date: Date.tomorrow + 2, time: "16:00:00", dentist: @dentist, patient: @patient)

    start_date = Date.tomorrow
    end_date = Date.tomorrow + 2

    # Chamando o método que realiza a busca de consultas por período
    @appointments = Appointment.where(date: start_date..end_date)

    # Verificando a quantidade e se as consultas estão no período devido
    assert_equal 3, @appointments.count, "Should return all appointments within the date range"
    assert @appointments.include?(appointment1), "Appointment should be within the date range"
    assert @appointments.include?(appointment2), "Appointment should be within the date range"
    assert @appointments.include?(appointment3), "Appointment should be within the date range"
  end

  # ... (outros testes)

  test "should destroy appointment correctly" do
    assert @appointment.save, "Failed to save the valid appointment"
    assert_not_nil @appointment.id, "Appointment ID should not be nil after save"

    assert_difference 'Appointment.count', -1 do
      @appointment.destroy
    end
  end
end
