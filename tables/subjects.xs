// Tabela de Disciplinas Acadêmicas
table subjects {
  auth = true

  schema {
    int id
    timestamp created_at?=now
    timestamp updated_at?=now
    text name filters=trim
    text code? filters=trim
    text description? filters=trim
    text semester? filters=trim
    decimal workload?
    int credits?
    int user_id {
      table = "user"
    }
    text owner filters=trim

    // Propriedades de controle
    bool is_active?=true
    text status? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
    {type: "btree", field: [{name: "user_id", op: "asc"}]}
    {type: "btree|unique", field: [{name: "user_id", op: "asc"}, {name: "code", op: "asc"}]}
  ]

  rules {
    create = "owner == $user.id"
    read = "owner == $user.id"
    update = "owner == $user.id"
    delete = "owner == $user.id"
  }
}
