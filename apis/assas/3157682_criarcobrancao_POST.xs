query criarcobrancao verb=POST {
  api_group = "Assas"
  auth = "user"

  input {
    text tipo filters=trim
    decimal valor filters=min:0
    date datavenc
    text descricao filters=trim
  }

  stack {
    // Pega o API Token Assas do SLFood
    db.get Token {
      field_name = "plataforma"
      field_value = "Asaas"
    } as $tokens1
  
    // Pega o Cliente que está logado
    db.get user {
      field_name = "user_id"
      field_value = `$auth.id`
    } as $CLIENTE1
  
    db.get CARTAOTOKNZD {
      field_name = "cliente_id"
      field_value = $CLIENTE1.id
    } as $CARTAOTOKNZD1
  
    // Corrigido: Usando headers como uma lista de strings
    api.request {
      url = "https://api-sandbox.asaas.com/v3/payments"
      method = "POST"
      params = {}
        |set:"billingType":$input.tipo
        |set:"customer":$CARTAOTOKNZD1.codigoclienteassas
        |set:"value":$input.valor
        |set:"dueDate":$input.datavenc
        |set:"description":$input.descricao
      headers = []
        |push:"User-Agent: XanoApp/1.0 (contact: gustavo. matsuda@aluno.faculdadeimpacta.com.br)"
        |push:"Accept: application/json"
        |push:$tokens1.Token
        |push:"Content-Type: application/json"
      verify_host = false
      verify_peer = false
    } as $api1
  
    conditional {
      if (`$var.api1.response.status` == 200) {
        db.get STATUS_TRANSACAO {
          field_name = "status"
          field_value = "Cobrança Criada"
        } as $STATUSTRANSACAO1
      }
    
      else {
        db.get STATUS_TRANSACAO {
          field_name = "status"
          field_value = "Erro na Criação da Cobrança"
        } as $STATUSTRANSACAO1
      }
    }
  
    db.add TRANSACAO {
      data = {
        created_at        : "now"
        clienteassas      : `$var.CARTAOTOKNZD1.codigoclienteassas`
        idpayment         : `$var.api1.response.result.id`
        tipo              : $input.tipo
        valor             : $input.valor
        datavenc          : $input.datavenc
        descricao         : $input.descricao
        statustransacao_id: `$var.STATUSTRANSACAO1.id`
      }
    } as $TRANSACAO1
  }

  response = {TRANSACAO: $api1}
}