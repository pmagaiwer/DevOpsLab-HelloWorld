# Trilha DevOps da 4Linux

![Pipeline Status](https://github.com/pmagaiwer/DevOpsLab-HelloWorld/actions/workflows/pipeline.yml/badge.svg)

## 📋 Sobre o Projeto

Aplicação Flask criada para exemplificar um pipeline CI/CD focado na validação de conteúdo HTML e execução local com Docker.

### 🎯 Objetivos

- ✅ **Pipeline CI/CD**: Validação automatizada do conteúdo HTML via GitHub Actions
- 🐳 **Docker Local**: Execução da aplicação em containers para desenvolvimento
- 📚 **Educacional**: Demonstrar práticas DevOps e containerização

## 🐳 Executando Localmente com Docker

### Opção 1: Docker Compose (Recomendado)

```bash
# Construir e executar a aplicação
docker-compose up --build

# Executar em background (modo daemon)
docker-compose up -d --build

# Parar a aplicação
docker-compose down

# Ver logs em tempo real
docker-compose logs -f
```

### Opção 2: Docker Direto

```bash
# Construir a imagem
docker build -t devopslab-helloworld .

# Executar o container (foreground)
docker run -p 5000:5000 devopslab-helloworld

# Executar em background
docker run -d -p 5000:5000 --name hello-world devopslab-helloworld

# Parar a aplicação
docker stop hello-world

# Remover o container
docker rm hello-world

# Ver logs
docker logs hello-world
```

### Opção 3: Script Helper

```bash
# Usar o script de conveniência
chmod +x docker-helper.sh

# Comandos disponíveis:
./docker-helper.sh build           # Construir imagem
./docker-helper.sh run             # Executar (foreground)
./docker-helper.sh run-bg          # Executar (background)
./docker-helper.sh stop            # Parar aplicação
./docker-helper.sh compose-up      # Docker compose (foreground)
./docker-helper.sh compose-up-bg   # Docker compose (background)
./docker-helper.sh compose-down    # Parar docker compose
./docker-helper.sh logs            # Ver logs
./docker-helper.sh clean           # Limpar containers/imagens
```

### 🌐 Acessando a Aplicação

Após executar qualquer uma das opções acima:
- **URL**: http://localhost:5000
- **Porta**: 5000

## 🚀 Pipeline CI/CD (Apenas Validação HTML)

⚠️ **Importante**: O pipeline no GitHub Actions é focado **APENAS** na validação do arquivo HTML, não executa Docker.

### Estrutura do Pipeline

O arquivo `.github/workflows/pipeline.yml` executa apenas:

#### 1. **HTML Validation** 
- **Validação de conteúdo**: Verifica elementos essenciais do HTML
- **Verificação de arquivos estáticos**: Confirma presença de CSS e imagens  
- **Validação sintática**: Analisa a estrutura HTML básica

#### 2. **Commit Changes**
- **Execução condicional**: Apenas em push para branch main
- **Commit automático**: Registra validações bem-sucedidas

### 🔍 Validações do Pipeline

O script `validate-html.sh` verifica:

#### Estrutura HTML
- ✅ DOCTYPE HTML5
- ✅ Atributo lang="pt-BR"
- ✅ Meta charset UTF-8
- ✅ Meta viewport
- ✅ Título da página
- ✅ Estrutura html/head/body

#### Conteúdo Específico
- ✅ Link para CSS principal
- ✅ Presença de "Trilha DevOps"
- ✅ Presença de "Trilha Containers"  
- ✅ Links para cursos da 4Linux

#### Arquivos Estáticos
- ✅ Arquivo `static/css/main.css`
- ✅ Diretório `static/imgs/`

### 🔧 Executar Validações Localmente

```bash
# Executar apenas as validações HTML
./validate-html.sh
```

## 📁 Estrutura do Projeto

```
📦 DevOpsLab-HelloWorld
├── 📁 .github/workflows/
│   └── 📄 pipeline.yml         # Pipeline CI/CD (só validação HTML)
├── 📁 static/
│   ├── 📁 css/
│   │   └── 📄 main.css         # Estilos principais
│   └── 📁 imgs/                # Imagens
├── 📁 templates/
│   └── 📄 index.html           # Página principal (validada pelo pipeline)
├── 📄 app.py                   # Aplicação Flask
├── 📄 validate-html.sh         # Script de validação HTML
├── 📄 docker-helper.sh         # Utilitário Docker (uso local)
├── 📄 Dockerfile               # Containerização (uso local)
├── 📄 docker-compose.yml       # Orquestração (uso local)
├── 📄 requirements.txt         # Dependências Python
└── 📄 README.md               # Esta documentação
```

## 🔄 Fluxos de Trabalho

### 💻 Desenvolvimento Local (com Docker)

1. **Modificar código**:
   ```bash
   # Editar templates/index.html, app.py, etc.
   ```

2. **Testar localmente**:
   ```bash
   # Opção 1: Docker Compose
   docker-compose up --build
   
   # Opção 2: Docker direto  
   docker build -t devopslab-helloworld .
   docker run -p 5000:5000 devopslab-helloworld
   
   # Opção 3: Script helper
   ./docker-helper.sh compose-up
   ```

3. **Validar HTML** (opcional):
   ```bash
   ./validate-html.sh
   ```

4. **Acessar**: http://localhost:5000

### ☁️ Pipeline Automático (GitHub Actions)

1. **Commit & Push**:
   ```bash
   git add .
   git commit -m "Atualização do conteúdo HTML"
   git push origin main
   ```

2. **Pipeline executa automaticamente**:
   - Valida arquivo `templates/index.html`
   - Verifica arquivos estáticos
   - Faz commit automático se tudo passar

3. **Monitorar**: Badge no README atualiza automaticamente

### 📊 Comandos Úteis

```bash
# Docker - Gerenciamento básico
docker ps                              # Ver containers rodando
docker images                          # Ver imagens locais
docker system prune -f                 # Limpar recursos não utilizados

# Docker Compose - Gerenciamento
docker-compose ps                      # Ver serviços rodando
docker-compose logs web               # Ver logs do serviço web
docker-compose exec web /bin/bash     # Acessar container

# Git - Acompanhar pipeline
git log --oneline                      # Ver commits recentes
git status                             # Ver status do repositório
```

## ⚙️ Configurações

### Pipeline (GitHub Actions)
- **Triggers**: Push em `main`/`develop`, Pull Request para `main`
- **Função**: Apenas validação HTML + commit automático
- **Não executa**: Docker, deploy, testes de aplicação

### Docker Local
- **Porta**: 5000
- **Volumes**: Código sincronizado para desenvolvimento
- **Rebuild**: Automático com `--build`

## 🏆 Benefícios

- **Desenvolvimento Local**: Docker facilita ambiente consistente
- **Validação Automática**: Pipeline garante qualidade do HTML  
- **Simplicidade**: Foco específico em validação de conteúdo
- **Feedback Visual**: Badge mostra status do pipeline
- **Flexibilidade**: Desenvolvimento local independente do pipeline

## 📚 Recursos Educacionais

Para maiores informações sobre DevOps e containerização:
- [Site da 4Linux](https://www.4linux.com.br/cursos/devops)
- [Trilha DevOps Completa](https://4linux.com.br/cursos/treinamento/ci-cd-integracao-e-entrega-continua-com-git-jenkins-nexus-e-sonar)
- [Docker Documentation](https://docs.docker.com/)

---

**Desenvolvido para fins educacionais - Trilha DevOps 4Linux** 🚀
