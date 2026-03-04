# 📖 Como Atualizar o Site com Novos Diagramas

## 🚀 Método 1: Scripts Automatizados (RECOMENDADO)

### ✨ Configuração única (primeira vez):
1. Abra o PowerShell como Administrador
2. Execute: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Digite `S` para confirmar
4. Feche o PowerShell

### ➕ Para ADICIONAR novos diagramas:
1. **Exporte o SVG do Bizagi:**
   - No Bizagi Modeler: `File` → `Publish` → selecione o diagrama
   - Salve o arquivo `.svg` em qualquer pasta

2. **Execute o script:**
   - Dê **duplo clique** em `adicionar-diagrama.ps1`
   - Cole o caminho da pasta ou do arquivo SVG
   - Digite o nome que aparecerá no site
   - Confirme!

3. **Pronto!** Deploy automático em 1-2 minutos ✨

### ➖ Para REMOVER diagramas:
1. Dê **duplo clique** em `remover-diagrama.ps1`
2. Digite o número do diagrama para remover
3. Digite `SIM` para confirmar
4. **Pronto!** Deploy automático em 1-2 minutos ✨

---

## ⚠️ IMPORTANTE: O que NÃO fazer

❌ **NÃO copie a pasta inteira** exportada do Bizagi para `diagrams/`  
✅ Copie APENAS os arquivos `.svg` OU use o script automatizado

❌ **NÃO adicione SVGs sem atualizar** `configuration.json.js`  
✅ Use o script `adicionar-diagrama.ps1` que faz tudo automaticamente

❌ **NÃO edite** `configuration.json.js` manualmente (pode quebrar o JSON)  
✅ Use os scripts automatizados que garantem JSON válido

---

## 🖱️ Método 2: GitHub Desktop (Alternativa Visual)

Se preferir uma interface gráfica após exportar os SVGs:

1. Instale o [GitHub Desktop](https://desktop.github.com/)
2. Adicione este repositório: `C:\Users\darkf\OneDrive\Documentos\lumafluxo`
3. Após usar os scripts, abra o GitHub Desktop
4. Ele mostrará as alterações automaticamente
5. Clique em **"Commit to main"** e depois **"Push origin"**

> **Nota:** Os scripts `adicionar-diagrama.ps1` e `remover-diagrama.ps1` já fazem commit e push automaticamente!

---

## 📋 Estrutura de Arquivos

Os arquivos `.svg` devem estar em:
```
public/files/diagrams/*.svg
Tentar publicar/files/diagrams/*.svg  (cópia sincronizada)
```

O arquivo de configuração:
```
public/libs/js/json/configuration.json.js
Tentar publicar/libs/js/json/configuration.json.js  (cópia sincronizada)
```

> **Os scripts automatizados cuidam de tudo isso para você!**

---

## 🎯 Diagramas Atualmente no Site

1. **Acompanhamento trimestral** (22 KB)
2. **Inspeção** (13 KB)
3. **Óbito - Atual** (489 KB)
4. **Resposta e processamento** (547 KB)

---

## ❓ Solução de Problemas

### ❌ O script não executa:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### ❌ "Caminho não encontrado" ao usar adicionar-diagrama.ps1:
- Cole o caminho completo do arquivo ou pasta
- Exemplo: `C:\Users\darkf\Downloads\Diagrama.svg`
- Ou: `C:\Users\darkf\Downloads\` (para buscar todos os SVGs)

### ❌ Netlify não está atualizando:
1. Aguarde 2-3 minutos (deploy leva tempo)
2. Recarregue com `Ctrl + Shift + R` (limpa cache)
3. Verifique o [GitHub](https://github.com/charlieloganx23/fluxobizagi) se o commit foi enviado
4. Veja os logs no [Netlify Dashboard](https://app.netlify.com/)

### ❌ Página não carrega após adicionar diagrama:
- Verifique se o arquivo SVG tem acento no nome (evite!)
- Use o script `remover-diagrama.ps1` para desfazer
- Preferencialmente: renomeie o SVG sem acentos antes de adicionar

### ❌ "Erro JSON" ou página em branco:
- O `configuration.json.js` pode estar quebrado
- Entre em contato para restaurar backup

---

## 🔗 Links Importantes

- 🌐 **Site Publicado:** https://repositorioprocessos.netlify.app
- 📦 **Repositório GitHub:** https://github.com/charlieloganx23/fluxobizagi
- ⚙️ **Netlify Dashboard:** https://app.netlify.com/

---

## 💡 Dicas Finais

✅ **Boas Práticas:**
- Use nomes de arquivo sem acentos ou caracteres especiais
- Mantenha os SVGs em tamanho razoável (< 1 MB se possível)
- Teste localmente antes de adicionar muitos diagramas de uma vez
- Use os scripts automatizados sempre que possível

✅ **Atalho Rápido:**
- Crie atalhos dos scripts na sua área de trabalho para acesso rápido
- Clique direito no `.ps1` → "Criar atalho" → Mova para área de trabalho

---

**📅 Última atualização:** 04/03/2026  
**✨ Scripts criados:** `adicionar-diagrama.ps1` e `remover-diagrama.ps1`
