table CARTAOTOKNZD {
  auth = false

  schema {
    int id
    timestamp created_at?=now
    text token? filters=trim
    text codigoclienteassas? filters=trim
    int cliente_id? {
      table = "user"
    }
  
    int status_tokeniza_o_id? {
      table = "STATUS_TTOKENIZACAO"
    }
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}