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
