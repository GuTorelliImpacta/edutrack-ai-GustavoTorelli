# API de Disciplinas Acadêmicas (Subjects)

## Visão Geral

A API de Subjects permite que cada usuário registre, gerencie e controle acesso às suas disciplinas acadêmicas. A implementação segue princípios de propriedade definida, permitindo futuras automações e integrações no sistema EduTrack-AI.

## Tabela: `subjects`

### Definição
- **ID Xano**: Será atribuído após sincronização
- **Autenticação**: Habilitada
- **Controle de Acesso**: Por proprietário (owner)

### Schema

| Campo | Tipo | Descrição | Obrigatório | Padrão |
|-------|------|-----------|-------------|--------|
| id | int | Identificador único | ✅ | Auto-increment |
| created_at | timestamp | Data de criação | ✅ | now |
| updated_at | timestamp | Data da última atualização | ✅ | now |
| name | text | Nome da disciplina | ✅ | - |
| code | text | Código da disciplina | ❌ | - |
| description | text | Descrição/ementa | ❌ | - |
| semester | text | Semestre/período | ❌ | - |
| workload | float | Carga horária | ❌ | - |
| credits | int | Número de créditos | ❌ | - |
| user_id | int | ID do usuário dono | ✅ | - |
| owner | text | Propriedade (validação) | ✅ | - |
| is_active | bool | Status ativo/inativo | ✅ | true |
| status | text | Estado customizável | ❌ | 'active' |

### Índices

```
1. PRIMARY KEY (id)
2. BTREE (created_at DESC) - Ordenação por data
3. BTREE (user_id ASC) - Filtro por usuário
4. UNIQUE (user_id ASC, code ASC) - Evita duplicatas por usuário
```

### Regras de Segurança (RLS)

```
CREATE:  owner == $user.id
READ:    owner == $user.id
UPDATE:  owner == $user.id
DELETE:  owner == $user.id
```

## Endpoints da API

### Base URL
```
https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1
```

### 1. Criar Disciplina
**POST** `/subjects`

**Autenticação**: Obrigatória (Bearer Token)

**Request Body**:
```json
{
  "name": "Matemática Discreta",
  "code": "MTD-101",
  "description": "Introdução a estruturas discretas e lógica",
  "semester": "2026-1",
  "workload": 60.0,
  "credits": 4
}
```

**Response** (201 Created):
```json
{
  "id": 1,
  "created_at": "2026-04-01T10:30:00+00:00",
  "updated_at": "2026-04-01T10:30:00+00:00",
  "name": "Matemática Discreta",
  "code": "MTD-101",
  "description": "Introdução a estruturas discretas e lógica",
  "semester": "2026-1",
  "workload": 60.0,
  "credits": 4,
  "user_id": 123,
  "owner": "123",
  "is_active": true,
  "status": "active"
}
```

### 2. Listar Disciplinas do Usuário
**GET** `/subjects`

**Autenticação**: Obrigatória (Bearer Token)

**Query Parameters**: Nenhum

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "created_at": "2026-04-01T10:30:00+00:00",
    "updated_at": "2026-04-01T10:30:00+00:00",
    "name": "Matemática Discreta",
    "code": "MTD-101",
    "description": "Introdução a estruturas discretas e lógica",
    "semester": "2026-1",
    "workload": 60.0,
    "credits": 4,
    "user_id": 123,
    "owner": "123",
    "is_active": true,
    "status": "active"
  },
  {
    "id": 2,
    "created_at": "2026-04-01T11:00:00+00:00",
    "updated_at": "2026-04-01T11:00:00+00:00",
    "name": "Algoritmos",
    "code": "ALG-201",
    "description": "Design e análise de algoritmos",
    "semester": "2026-1",
    "workload": 90.0,
    "credits": 6,
    "user_id": 123,
    "owner": "123",
    "is_active": true,
    "status": "active"
  }
]
```

### 3. Obter Disciplina Específica
**GET** `/subjects/:id`

**Autenticação**: Obrigatória (Bearer Token)

**Path Parameters**:
- `id` (int, required): ID da disciplina

**Response** (200 OK):
```json
{
  "id": 1,
  "created_at": "2026-04-01T10:30:00+00:00",
  "updated_at": "2026-04-01T10:30:00+00:00",
  "name": "Matemática Discreta",
  "code": "MTD-101",
  "description": "Introdução a estruturas discretas e lógica",
  "semester": "2026-1",
  "workload": 60.0,
  "credits": 4,
  "user_id": 123,
  "owner": "123",
  "is_active": true,
  "status": "active"
}
```

### 4. Atualizar Disciplina
**PATCH** `/subjects/:id`

**Autenticação**: Obrigatória (Bearer Token)

**Path Parameters**:
- `id` (int, required): ID da disciplina

**Request Body** (todos os campos opcionais):
```json
{
  "name": "Matemática Discreta Avançada",
  "code": "MTD-102",
  "description": "Tópicos avançados em estruturas discretas",
  "semester": "2026-2",
  "workload": 75.0,
  "credits": 5,
  "is_active": true,
  "status": "em_progresso"
}
```

**Response** (200 OK): Retorna objeto atualizado

### 5. Deletar Disciplina
**DELETE** `/subjects/:id`

**Autenticação**: Obrigatória (Bearer Token)

**Path Parameters**:
- `id` (int, required): ID da disciplina

**Response** (204 No Content)

## Códigos de Status HTTP

| Código | Descrição |
|--------|-----------|
| 200 | OK - Requisição bem-sucedida |
| 201 | Created - Recurso criado com sucesso |
| 204 | No Content - Requisição bem-sucedida, sem conteúdo de resposta |
| 400 | Bad Request - Erro na validação do payload |
| 401 | Unauthorized - Token inválido ou ausente |
| 403 | Forbidden - Usuário não tem permissão (não é o proprietário) |
| 404 | Not Found - Recurso não encontrado |
| 409 | Conflict - Conflito (ex: código duplicado para este usuário) |
| 429 | Too Many Requests - Limite de requisições excedido |
| 500 | Internal Server Error - Erro no servidor |

## Exemplos de Uso

### cURL

**Criar disciplina**:
```bash
curl -X POST https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Matemática Discreta",
    "code": "MTD-101",
    "description": "Introdução a estruturas discretas",
    "semester": "2026-1",
    "workload": 60.0,
    "credits": 4
  }'
```

**Listar disciplinas**:
```bash
curl -X GET https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Obter uma disciplina**:
```bash
curl -X GET https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects/1 \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Atualizar disciplina**:
```bash
curl -X PATCH https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects/1 \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "concluído"
  }'
```

**Deletar disciplina**:
```bash
curl -X DELETE https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects/1 \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### JavaScript/Fetch

```javascript
// Criar disciplina
const createSubject = async (token, data) => {
  const response = await fetch(
    'https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects',
    {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }
  );
  return await response.json();
};

// Listar disciplinas
const listSubjects = async (token) => {
  const response = await fetch(
    'https://x8ki-letl-twmt.n7.xano.io/api:LSNi-FA0:v1/subjects',
    {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${token}`
      }
    }
  );
  return await response.json();
};
```

## Validações e Constraints

### Campo: `name`
- Tipo: text
- Obrigatório: Sim
- Filtro: trim
- Tamanho: Sem limite de caracteres definido
- Constraints: Nenhum

### Campo: `code`
- Tipo: text
- Obrigatório: Não
- Filtro: trim
- Constraints: Único por usuário (índice UNIQUE user_id, code)

### Campo: `user_id`
- Tipo: int
- Obrigatório: Sim (preenchido automaticamente)
- Referência: Tabela `user` (id)
- Automático: Obtido do token de autenticação

### Campo: `owner`
- Tipo: text
- Obrigatório: Sim
- Valor: user_id (como string)
- Validação: Deve ser igual ao `$user.id` para operações CRUD

## Segurança

### Autenticação
- Todos os endpoints exigem Bearer Token JWT
- Token obtido através do endpoint `/auth/signup` ou `/auth/login`

### Autorização
- Implementada via RLS (Row Level Security)
- Usuário só pode acessar/modificar seus próprios registros
- Campo `owner` valida propriedade em tempo de execução

### Validação de Entrada
- Todos os campos de texto têm trim automático
- Timestamps são imutáveis (criados/atualizados pelo sistema)
- Referências externas são validadas

## Casos de Uso

### 1. Aluno Registrando Suas Disciplinas
```
1. Aluno se autentica
2. POST /subjects com dados da disciplina
3. Sistema cria registro vinculado ao user_id
4. Aluno recebe confirmação com ID da disciplina
```

### 2. Consultar Disciplinas Matriculado
```
1. Aluno se autentica
2. GET /subjects
3. Sistema retorna apenas suas disciplinas
4. Aluno visualiza lista ordenada por data de criação
```

### 3. Atualizar Status de Disciplina
```
1. Aluno se autentica
2. PATCH /subjects/{id} com novo status
3. Sistema valida propriedade
4. Atualiza apenas campos permitidos
```

### 4. Remover Disciplina
```
1. Aluno se autentica
2. DELETE /subjects/{id}
3. Sistema valida proprietário
4. Remove registro de forma segura
```

## Futuras Automações

A estrutura de subjects foi projetada para permitir:

- **Cálculo de Médias**: Integração com notas/avaliações
- **Notificações**: Alertas sobre prazos e avaliações
- **Relatórios**: Geração de histórico acadêmico
- **Sincronização**: Integração com sistemas acadêmicos externos
- **Analytics**: Análise de desempenho e progresso
- **Recomendações**: Sugestões de disciplinas baseadas em histórico

## Estrutura de Arquivos

```
📁 apis/subjects/
├── api_group.xs              # Definição do grupo de API
├── criar_subject_POST.xs     # Endpoint: POST /subjects
├── listar_subjects_GET.xs    # Endpoint: GET /subjects
├── obter_subject_GET.xs      # Endpoint: GET /subjects/:id
├── atualizar_subject_PATCH.xs # Endpoint: PATCH /subjects/:id
└── deletar_subject_DELETE.xs  # Endpoint: DELETE /subjects/:id

📁 tables/
└── subjects.xs               # Definição da tabela

📁 docs/
└── SUBJECTS_API.md           # Esta documentação
```

## Status de Implementação

- ✅ Tabela criada
- ✅ API Group sincronizado (ID: LSNi-FA0)
- ✅ 5 Endpoints CRUD implementados
- ✅ Controle de acesso por proprietário
- ✅ Documentação completa
- ⏳ IDs de endpoints serão atribuídos após sincronização Xano

## Histórico de Commits

```
commit a10adb4
Author: Gustavo Torelli Viscondi <2503716@salas.aulas>
Date:   Wed Apr 1 2026

    feat: criar base de dados subjects com CRUD e controle de acesso por proprietário
```

## Referências

- [Documentação Xano](https://www.xano.com/)
- [XanoScript Documentation](https://docs.xano.com/article/20)
- [REST API Best Practices](https://restfulapi.net/)
