# Visualizador de Processos Bizagi - LumaFluxo

Este é um visualizador de processos publicado pelo Bizagi Modeler, pronto para ser hospedado no Netlify.

## 📋 Descrição

Projeto de visualização do processo "Maus tratos (situação de pessoa privada de liberdade)" exportado do Bizagi Modeler.

Atualmente contém 3 diagramas:
- Diagrama 1
- Acompanhamento trimestral
- Resposta e processamento

## ➕ Como Adicionar Novos Diagramas ao Site

**⚠️ IMPORTANTE:** Não adicione apenas arquivos SVG! Veja o guia completo: [COMO-ATUALIZAR.md - Seção de Novos Diagramas](COMO-ATUALIZAR.md#-como-adicionar-novos-diagramas-ao-site)

### Resumo Rápido:

**Opção 1 (Recomendada):** Exporte o projeto COMPLETO do Bizagi com todos os diagramas

**Opção 2:** Adicione SVGs manualmente + edite `configuration.json.js` nas 2 pastas (`public/` e `Tentar publicar/`)

### ⚡ Por que preciso editar configuration.json.js?
O Bizagi usa este arquivo para saber quais diagramas mostrar no sidebar. Apenas copiar SVGs não funciona!

## 🚀 Como Atualizar Diagramas Existentes

**Veja o guia completo:** [COMO-ATUALIZAR.md](COMO-ATUALIZAR.md)

### Método Rápido (Recomendado):
1. Exporte o diagrama do Bizagi para a pasta `public/`
2. Execute o arquivo `deploy.ps1` (duplo clique)
3. Digite uma descrição e pressione ENTER
4. Pronto! O site atualiza automaticamente em 1-2 minutos ✨

### Alternativas:
- **`deploy-rapido.bat`** - Versão simplificada do script
- **GitHub Desktop** - Interface visual e amigável
- **Git CLI** - Para usuários avançados

## 🚀 Como Hospedar no Netlify

### Opção 1: Via Interface Web do Netlify

1. Acesse [netlify.com](https://www.netlify.com/) e faça login
2. Clique em **"Add new site"** → **"Deploy manually"**
3. Arraste a pasta raiz do projeto para a área de upload
4. Aguarde o deploy ser concluído
5. Seu site estará disponível em uma URL fornecida pelo Netlify (ex: `https://seu-site.netlify.app`)

### Opção 2: Via Git (Recomendado)

1. Inicialize um repositório Git nesta pasta:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. Crie um repositório no GitHub/GitLab/Bitbucket e faça push:
   ```bash
   git remote add origin <URL-DO-SEU-REPOSITORIO>
   git push -u origin main
   ```

3. No Netlify:
   - Clique em **"Add new site"** → **"Import an existing project"**
   - Conecte seu repositório
   - O Netlify detectará automaticamente as configurações do arquivo `netlify.toml`
   - Clique em **"Deploy site"**

### Opção 3: Via Netlify CLI

1. Instale o Netlify CLI:
   ```bash
   npm install -g netlify-cli
   ```

2. Faça login no Netlify:
   ```bash
   netlify login
   ```

3. Inicialize e faça deploy:
   ```bash
   netlify init
   netlify deploy --prod
   ```

## 📁 Estrutura do Projeto

```
lumafluxo/
├── netlify.toml           # Configurações do Netlify
├── README.md              # Este arquivo
└── Tentar publicar/       # Pasta com o site (configurada como publish no netlify.toml)
    ├── index.html         # Página principal
    ├── key.json.js        # Configurações do visualizador
    ├── files/
    │   └── diagrams/      # Diagramas SVG dos processos
    └── libs/              # Bibliotecas CSS e JavaScript
        ├── css/
        └── js/
```

## ⚙️ Configurações

O arquivo `key.json.js` contém as configurações personalizáveis do visualizador:

- **useTheme**: Usar tema personalizado
- **preserveHTML**: Preservar formatação HTML
- **showPublishDate**: Exibir data de publicação
- **subNavigation**: Mostrar barra de subnavegação
- **showPerformersList**: Mostrar lista de executantes

## 🌐 Após o Deploy

Após o deploy, você pode:

- Configurar um domínio personalizado nas configurações do Netlify
- Habilitar HTTPS (automático no Netlify)
- Configurar variáveis de ambiente se necessário
- Monitorar o tráfego e performance

## 📝 Notas

- Este é um site estático - não requer servidor ou banco de dados
- Compatível com navegadores modernos (Chrome, Firefox, Edge)
- Suporte para IE8+ (com algumas limitações)

## 📅 Última Publicação

27/02/2026 10:03:59

---

**Desenvolvido com Bizagi Modeler**
