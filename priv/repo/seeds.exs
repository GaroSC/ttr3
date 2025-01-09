# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExpoEscom.Repo.insert!(%ExpoEscom.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ExpoEscom.Eventos.Departamento
alias ExpoEscom.Eventos.Academia
alias ExpoEscom.Accounts.User

cic = %Departamento{
  nombre: "Ciencias e Ingeniería de la Computación",
  academias: [
    %Academia{nombre: "Ingeniería en inteligencia Artificial"},
    %Academia{nombre: "Ciencia de datos"},
    %Academia{nombre: "Fundamentos de sistemas eléctricos"},
    %Academia{nombre: "Ciencias de la computación"}
  ]
}

isc = %Departamento{
  nombre: "Ingeniería en Sistemas Computacionales",
  academias: [
    %Academia{nombre: "Ingeniería de software"},
    %Academia{nombre: "Sistemas distribuidos"},
    %Academia{nombre: "Sistemas digitales"},
    %Academia{nombre: "Proyectos estratégicos y toma de decisiones"}
  ]
}

formacion_institucional = %Departamento{
  nombre: "Formación institucional",
  academias: [
    %Academia{nombre: "Ciencias sociales"},
    %Academia{nombre: "Trabajo terminal"}
  ]
}

formacion_basica = %Departamento{
  nombre: "Formación básica",
  academias: [
    %Academia{nombre: "Ciencias básicas"}
  ]
}

Ash.Seed.seed!([cic, isc, formacion_basica, formacion_institucional])

User
|> Ash.Changeset.for_create(:register_with_password, %{
  nombres: "Admin",
  apellido_paterno: "ESCOM",
  email: "admin@example.com",
  password: "escomescom",
  password_confirmation: "escomescom"
})
|> Ash.create!()
