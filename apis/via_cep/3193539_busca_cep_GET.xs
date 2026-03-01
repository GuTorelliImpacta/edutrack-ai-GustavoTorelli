// Query all CEP records
query "/buscaCEP" verb=GET {
  api_group = "ViaCEP"

  input {
  }

  stack {
  }

  response = $model
}