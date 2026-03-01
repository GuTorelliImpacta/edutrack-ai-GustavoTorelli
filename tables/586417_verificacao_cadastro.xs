table verificacao_cadastro {
  auth = false

  schema {
    int id
    timestamp created_at?=now
    int codigo_verificacao?
    int user_id? {
      table = "user"
    }
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}