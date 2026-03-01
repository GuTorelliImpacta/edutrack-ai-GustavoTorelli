query criarclienteassas verb=POST {
  api_group = "Assas"

  input {
    text authtoken? filters=trim
  }

  stack {
    api.request {
      url = `"https://x8ki-letl-twmt.n7.xano.io/api:yLwZaGh6/consultaCliente"`
      method = "GET"
      params = {authtoken: $input.authtoken}
    } as $api1
  
    conditional {
      if (`$api1.response.status` == 200) {
        db.get user {
          field_name = "id"
          field_value = `$var.api1.response.result.result1.cliente.user_id`
        } as $user1
      
        db.get Token {
          field_name = "plataforma"
          field_value = "Asaas"
        } as $tokens1
      
        api.request {
          url = "https://api-sandbox.asaas.com/v3/customers"
          method = "POST"
          params = {
            name   : $user1.name
            cpfCnpj: $api1.response.result.result1.cliente.CPF
          }
        
          headers = []
            |push:"User-Agent: XanoApp/1.0 (contact: gustavo.matsuda@aluno.faculdadeimpacta.com.br)"
            |push:"Accept: application/json"
            |push:$tokens1.Token
            |push:"Content-Type: application/json"
        } as $api2
      
        var $codigoclienteassas {
          value = `$var.api2.response.result.id`
        }
      
        db.get STATUS_TTOKENIZACAO {
          field_name = "status"
          field_value = `"Criada"`
        } as $STATUS_TTOKENIZACAO1
      
        db.add TTOKENIZACAO {
          data = {
            created_at            : "now"
            cliente_id            : `$var.api1.response.result.cliente.id`
            det_cartao_encript    : ""
            status_ttokenizacao_id: `$var.STATUS_TTOKENIZACAO1.id`
          }
        } as $TTOKENIZACAO1
      
        db.add CARTAOTOKNZD {
          data = {
            created_at          : "now"
            token               : ""
            codigoclienteassas  : `$var.codigoclienteassas`
            cliente_id          : `$var.api1.response.result.result1.cliente.id`
            status_tokeniza_o_id: "0"
          }
        } as $CARTAOTOKNZD1
      
        var $status {
          value = {status: true, mensagem: "Cliente cadastrado no Assas."}
        }
      }
    
      else {
        var $status {
          value = {
            status  : false
            mensagem: "Cliente não pôde ser cadastrado no Assas."
          }
        }
      }
    }
  }

  response = {status: $status}
}