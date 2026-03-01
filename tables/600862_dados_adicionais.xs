table dados_adicionais {
  auth = false

  schema {
    int id
    int user_id? {
      table = "user"
    }
  
    text nomeendereco? filters=trim
    text cep? filters=trim
    text rua? filters=trim
    text bairro? filters=trim
    text numero? filters=trim
    text complemento? filters=trim
  }

  index = [{type: "primary", field: [{name: "id"}]}]
}