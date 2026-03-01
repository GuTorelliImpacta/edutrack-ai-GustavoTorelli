// Meu primeiro comentário via VS Code.
table user {
  auth = true

  schema {
    int id
    timestamp created_at?=now
    text name filters=trim
    text telefone? filters=trim
    email? email filters=trim|lower
    password? password filters=min:8|minAlpha:1|minDigit:1
    bool is_active?
    bool profile_complete?
    int user_id? {
      table = "user"
    }
  
    text CPF? filters=trim
    int status_tokenizacao_id? {
      table = "STATUS_TTOKENIZACAO"
    }
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
    {type: "btree|unique", field: [{name: "email", op: "asc"}]}
  ]
}