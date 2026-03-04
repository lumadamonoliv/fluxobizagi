# 📖 Como Atualizar o Site com Novos Diagramas

## 🚀 Método 1: Script Automático (Mais Rápido)

### Primeira vez (Configuração única):
1. Abra o PowerShell como Administrador
2. Execute: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Digite `S` para confirmar

### Para cada atualização:
1. **Exporte o diagrama do Bizagi:**
   - No Bizagi Modeler: `File` → `Export` → `Web (HTML)`
   - Salve em uma pasta temporária

2. **Copie os arquivos:**
   - Copie o conteúdo exportado para a pasta `public/`
   - Substitua os arquivos antigos quando solicitado

3. **Execute o script:**
   - Dê **duplo clique** em `deploy.ps1`
   - OU abra PowerShell e digite: `.\deploy.ps1`
   - Digite uma descrição (ou pressione ENTER)
   - Aguarde o script terminar

4. **Pronto!** O Netlify fará deploy automático em 1-2 minutos ✨

---

## 🖱️ Método 2: GitHub Desktop (Mais Visual)

### Primeira vez:
1. Instale o [GitHub Desktop](https://desktop.github.com/)
2. Faça login com sua conta do GitHub
3. Adicione este repositório: `File` → `Add Local Repository`
4. Selecione a pasta: `C:\Users\darkf\OneDrive\Documentos\lumafluxo`

### Para cada atualização:
1. Exporte o diagrama do Bizagi para a pasta `public/`
2. Abra o GitHub Desktop
3. Ele mostrará automaticamente as alterações
4. Escreva uma descrição no campo "Summary"
5. Clique em **"Commit to main"**
6. Clique em **"Push origin"**
7. Pronto! Netlify faz deploy automático ✨

---

## ⌨️ Método 3: Linha de Comando (Para usuários avançados)

```powershell
# Navegue até a pasta do projeto
cd C:\Users\darkf\OneDrive\Documentos\lumafluxo

# Adicione todos os arquivos
git add -A

# Faça o commit
git commit -m "Atualização de diagramas"

# Envie para o GitHub
git push

# O Netlify faz deploy automático!
```

---

## 📋 Estrutura de Pastas

Quando exportar do Bizagi, certifique-se de manter esta estrutura:

```
public/
├── index.html                    ← Página principal
├── key.json.js                   ← Configurações
├── files/
│   └── diagrams/                 ← Seus diagramas SVG aqui
│       └── Diagrama 1.svg
└── libs/                         ← Bibliotecas (não mexa)
```

---

## ➕ Como Adicionar Novos Diagramas ao Site

### ⚠️ IMPORTANTE: NÃO adicione apenas arquivos SVG!

O Bizagi precisa saber que os novos diagramas existem. Existem **2 formas corretas**:

### ✅ Opção 1: Exportar Projeto COMPLETO (Recomendado)

1. **No Bizagi Modeler:**
   - Abra o projeto que contém TODOS os diagramas
   - `File` → `Publish` → `Web`
   - ⚠️ **Certifique-se que TODOS os diagramas estão no mesmo projeto**
   - Salve em pasta temporária

2. **Copiar arquivos:**
   ```powershell
   # Copiar tudo para as 2 pastas
   Copy-Item "C:\Temp\Bizagi Export\*" "public\" -Recurse -Force
   Copy-Item "C:\Temp\Bizagi Export\*" "Tentar publicar\" -Recurse -Force
   ```

3. **Commit e Push:**
   - Use o script `deploy.ps1` OU GitHub Desktop
   - Pronto! Diagramas aparecem no sidebar automaticamente

### ✅ Opção 2: Adicionar Manualmente ao configuration.json.js

Se você só tem os arquivos SVG novos:

1. **Copie os SVG para as pastas:**
   ```powershell
   Copy-Item "C:\Temp\Novo Diagrama.svg" "public\files\diagrams\" -Force
   Copy-Item "C:\Temp\Novo Diagrama.svg" "Tentar publicar\files\diagrams\" -Force
   ```

2. **Edite o arquivo de configuração:**
   - Abra: `Tentar publicar\libs\js\json\configuration.json.js`
   - Localize: `"pages":[...`
   - Adicione novo diagrama na lista:

   ```javascript
   "pages":[
     {
       "id":"eb8fe458-7272-4a2d-becd-74e37acb504e",
       "name":"Diagrama 1",
       "version":"1.0",
       "author":"Usuário",
       "image":"files/diagrams/Diagrama 1.svg",
       "isSubprocessPage":false,
       "isCallActivityPage":false,
       "elements":[],
       "subPages":[]
     },
     // ⬇️ ADICIONE AQUI (copie e cole o bloco acima, mudando)
     {
       "id":"GERE-UM-ID-UNICO-AQUI",  // Mude os últimos dígitos
       "name":"Nome do Novo Diagrama",
       "version":"1.0",
       "author":"Usuário",
       "image":"files/diagrams/Nome do Arquivo.svg",
       "isSubprocessPage":false,
       "isCallActivityPage":false,
       "elements":[],
       "subPages":[]
     }
   ]
   ```

3. **Copie também para `public/`:**
   ```powershell
   Copy-Item "Tentar publicar\libs\js\json\configuration.json.js" "public\libs\js\json\" -Force
   ```

4. **Commit e Push**

### ❌ O que NÃO fazer:

- ❌ Não adicionar só SVG sem atualizar `configuration.json.js`
- ❌ Não criar pastas separadas tipo "Diagrama 2/"
- ❌ Não copiar arquivos apenas para `public/` (precisa estar em `Tentar publicar/` também!)

### 🎯 Checklist Rápido:

- [ ] Diagramas SVG em `public/files/diagrams/` E `Tentar publicar/files/diagrams/`
- [ ] `configuration.json.js` atualizado em AMBAS as pastas
- [ ] Commit e push feitos
- [ ] Aguardou 1-2 minutos para deploy do Netlify
- [ ] Testou com `Ctrl + Shift + R` (force refresh)

---

## ⚠️ Importante: Ajustar Caminhos no Bizagi

Para evitar problemas de caminho, no arquivo gerado pelo Bizagi:

**Arquivo:** `public/libs/js/json/configuration.json.js`

Certifique-se que os caminhos usam **barras normais** `/` e não `\`:

✅ Correto: `"image": "files/diagrams/Diagrama 1.svg"`  
❌ Errado: `"image": "files\\diagrams\\Diagrama 1.svg"`

---

## 🔗 Links Úteis

- **Seu Repositório:** https://github.com/charlieloganx23/fluxobizagi
- **Netlify Dashboard:** https://app.netlify.com/
- **Status do Deploy:** Acesse o Netlify para ver o progresso

---

## ❓ Solução de Problemas

### O script não executa:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Erro de autenticação Git:
- Configure suas credenciais:
```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

### Netlify não está atualizando:
1. Verifique se o push foi bem-sucedido no GitHub
2. Acesse o dashboard do Netlify
3. Verifique os logs de deploy

---

## 💡 Dica Pro

Crie um **atalho** para o `deploy.ps1` na sua área de trabalho:
1. Clique direito em `deploy.ps1`
2. Enviar para → Área de trabalho (criar atalho)
3. Agora você pode fazer deploy com duplo clique! 🚀
