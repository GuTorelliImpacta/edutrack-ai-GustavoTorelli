// CEP cadastrados dos clientes
table CEP {
  auth = false

  schema {
    int id
    timestamp created_at?=now {
      visibility = "private"
    }
  
    text CEP? filters=trim
    text uf? filters=trim
    text Estado? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
    {type: "btree|unique", field: [{name: "CEP", op: "asc"}]}
  ]
}