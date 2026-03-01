// Transações de Tokenização dos Cartões de Créditos e Cartões de Débitos
table TTOKENIZACAO {
  auth = false

  schema {
    int id
    timestamp created_at?=now
    int cliente_id?=168 {
      table = "user"
    }
  
    int status_tokeniza_o_id?=1 {
      table = "STATUS_TTOKENIZACAO"
    }
  
    text? det_cartao_encript? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}