table STATUS_TTOKENIZACAO {
  auth = false

  schema {
    int id
    timestamp created_at?=now
    text status? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}