# 🚀 Scripts Automatizados - Guia Rápido

## 📥 adicionar-diagrama.ps1

**Para adicionar novos diagramas ao site:**

1. **Exporte o SVG** do Bizagi Modeler
2. **Duplo clique** em `adicionar-diagrama.ps1`
3. Cole o caminho da pasta ou arquivo SVG
4. Digite o nome para aparecer no site
5. **Pronto!** Deploy automático em 1-2 minutos

### Exemplo:
```
Caminho: C:\Users\darkf\Downloads\Novo Diagrama.svg
Nome no site: Fluxo de Atendimento
✓ Adicionado e publicado automaticamente!
```

---

## 🗑️ remover-diagrama.ps1

**Para remover diagramas do site:**

1. **Duplo clique** em `remover-diagrama.ps1`
2. Digite o **número** do diagrama para remover
3. Digite **SIM** para confirmar
4. **Pronto!** Removido e deploy automático

### Exemplo:
```
[1] Acompanhamento trimestral.svg
[2] Inspeção.svg
[3] Óbito - Atual.svg

Escolha: 2

✓ Inspeção.svg removido do site!
```

---

## ⚙️ Primeira Vez (Configuração Única)

Se os scripts não executarem, abra PowerShell como **Administrador** e rode:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Digite `S` para confirmar. **Isso é feito apenas UMA vez!**

---

## ✅ O que os scripts fazem automaticamente:

- ✓ Copiam arquivos para os locais corretos (`public/` e `Tentar publicar/`)
- ✓ Atualizam `configuration.json.js` com JSON válido
- ✓ Sincronizam todas as mudanças
- ✓ Fazem commit e push para GitHub
- ✓ Acionam deploy automático no Netlify

**Você só precisa clicar duas vezes! 🎯**

---

## 📖 Documentação Completa

Para mais detalhes, veja: [COMO-ATUALIZAR.md](COMO-ATUALIZAR.md)

---

**Dica:** Crie atalhos dos scripts na sua área de trabalho para acesso rápido!
