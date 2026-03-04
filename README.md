# Visualizador de Processos Bizagi - LumaFluxo

Este é um visualizador de processos publicado pelo Bizagi Modeler, hospedado no Netlify.

**🌐 Site Publicado:** https://repositorioprocessos.netlify.app

## 📋 Descrição

Projeto de visualização do processo "Maus tratos (situação de pessoa privada de liberdade)" exportado do Bizagi Modeler.

### 📊 Diagramas Atuais (4):
1. **Acompanhamento trimestral** (22 KB)
2. **Inspeção** (13 KB)
3. **Óbito - Atual** (489 KB)
4. **Resposta e processamento** (547 KB)

---

## 🚀 Como Adicionar/Remover Diagramas

Escolha o método que preferir:

### 🎯 Método 1: Scripts Automatizados (RECOMENDADO - Mais Fácil)

**➕ Adicionar diagrama:**
1. Dê duplo clique em **`adicionar-diagrama.ps1`**
2. Cole o caminho do arquivo SVG
3. Digite o nome que aparecerá no site
4. **Pronto!** ✨

**➖ Remover diagrama:**
1. Dê duplo clique em **`remover-diagrama.ps1`**
2. Digite o número do diagrama
3. Digite `SIM` para confirmar
4. **Pronto!** ✨

📖 **Guia completo:** [README-SCRIPTS.md](README-SCRIPTS.md)

---

### 🌐 Método 2: GitHub Web (De Qualquer Computador)

Adicione diagramas direto pelo navegador, sem instalar nada!

1. Faça upload do SVG no GitHub
2. Edite o arquivo `configuration.json.js`
3. Commit e aguarde deploy automático

📖 **Guia passo a passo:** [PUBLICAR-VIA-GITHUB-WEB.md](PUBLICAR-VIA-GITHUB-WEB.md)

---

### 💻 Método 3: Manual Completo (Para Usuários Avançados)

- Exportar projeto completo do Bizagi
- Editar manualmente arquivos de configuração
- Usar Git CLI ou GitHub Desktop

📖 **Guia detalhado:** [COMO-ATUALIZAR.md](COMO-ATUALIZAR.md)
---

## 📚 Documentação Completa

- **[README-SCRIPTS.md](README-SCRIPTS.md)** - Guia rápido dos scripts automatizados
- **[PUBLICAR-VIA-GITHUB-WEB.md](PUBLICAR-VIA-GITHUB-WEB.md)** - Como adicionar diagramas pelo navegador
- **[COMO-ATUALIZAR.md](COMO-ATUALIZAR.md)** - Documentação técnica completa

---

## 🔧 Tecnologia

- **Bizagi Modeler v2024** - Ferramenta de modelagem BPMN
- **Kinetic.js 4.x** - Renderização de canvas
- **Foundation.js** - Framework CSS
- **Netlify** - Hospedagem e deploy automático
- **GitHub** - Versionamento e backup

---

## 🌐 Site e Repositório

- **🌐 Site Publicado:** https://repositorioprocessos.netlify.app
- **📦 Repositório GitHub:** https://github.com/charlieloganx23/fluxobizagi
- **⚙️ Netlify Dashboard:** https://app.netlify.com/

---

## 📁 Estrutura do Projeto

```
lumafluxo/
├── adicionar-diagrama.ps1    # Script para adicionar diagramas
├── remover-diagrama.ps1      # Script para remover diagramas
├── deploy.ps1                # Script de deploy rápido
├── netlify.toml              # Configurações do Netlify
├── README.md                 # Este arquivo
├── README-SCRIPTS.md         # Guia dos scripts
├── PUBLICAR-VIA-GITHUB-WEB.md # Guia GitHub Web
├── COMO-ATUALIZAR.md         # Documentação técnica
├── public/                   # Arquivos fonte (desenvolvimento)
│   ├── files/diagrams/       # SVGs dos diagramas
│   └── libs/js/json/         
│       └── configuration.json.js  # Configuração dos diagramas
└── Tentar publicar/          # Pasta publicada no Netlify
    ├── index.html
    ├── files/diagrams/       # Cópia dos SVGs
    └── libs/                 # Bibliotecas e configurações
```

---

## ⚙️ Como Funciona

1. **SVGs são armazenados** em `files/diagrams/`
2. **configuration.json.js** define quais diagramas aparecem na sidebar
3. **Git push** aciona deploy automático no Netlify
4. **Site atualizado** em 1-2 minutos

**⚠️ IMPORTANTE:** Sempre mantenha sincronizado:
- `public/` (arquivos fonte)
- `Tentar publicar/` (arquivos que vão para o site)

Os scripts automatizados garantem essa sincronização!

---

## ❓ Suporte e Solução de Problemas

- Configurar um domínio personalizado nas configurações do Netlify
- Habilitar HTTPS (automático no Netlify)
- Configurar variáveis de ambiente se necessário
- Monitorar o tráfego e performance

## 📝 Notas

- Este é um site estático - não requer servidor ou banco de dados
- Compatível com navegadores modernos (Chrome, Firefox, Edge)

**Problemas comuns e soluções:**

### ❌ Scripts não executam
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### ❌ Página não carrega após adicionar diagrama
- Verifique se o arquivo `configuration.json.js` está com JSON válido
- Use `git log` para ver últimas mudanças
- Reverta o último commit se necessário

### ❌ Diagrama não aparece na sidebar
- Confirme que o arquivo SVG está em `Tentar publicar/files/diagrams/`
- Verifique se o nome no `configuration.json.js` está exato (case-sensitive)
- Aguarde 2-3 minutos e faça hard refresh (Ctrl+Shift+R)

📖 **Mais soluções:** Veja os guias de documentação listados acima

---

## 📅 Informações do Projeto

- **Última Atualização:** 04/03/2026
- **Diagramas Atuais:** 4 processos
- **Status:** ✅ Online e funcionando
- **Deploy Automático:** ✅ Ativo via GitHub → Netlify

---

## 💡 Dicas Úteis

- 🎯 Use os scripts automatizados sempre que possível
- 🌐 GitHub Web é útil para edições rápidas de qualquer lugar
- 💾 Faça backup local dos SVGs importantes
- 🔄 O Netlify faz deploy em 1-2 minutos após o push
- 🧹 Use Ctrl+Shift+R para forçar refresh sem cache

---

**Desenvolvido com Bizagi Modeler** | Hospedado no Netlify | Versionado no GitHub
