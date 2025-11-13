#!/bin/bash

# Script de validação do conteúdo HTML
# Valida a estrutura e conteúdo essencial do index.html

HTML_FILE="templates/index.html"
VALIDATION_PASSED=true

echo "🔍 Iniciando validação do arquivo HTML..."

# Verificar se o arquivo existe
if [ ! -f "$HTML_FILE" ]; then
    echo "❌ Erro: Arquivo $HTML_FILE não encontrado!"
    exit 1
fi

echo "✅ Arquivo $HTML_FILE encontrado"

# Validações de conteúdo essencial
echo "🔍 Validando conteúdo essencial..."

# Verificar DOCTYPE
if grep -q "<!DOCTYPE html>" "$HTML_FILE"; then
    echo "✅ DOCTYPE HTML5 presente"
else
    echo "❌ DOCTYPE HTML5 não encontrado"
    VALIDATION_PASSED=false
fi

# Verificar lang
if grep -q 'lang="pt-BR"' "$HTML_FILE"; then
    echo "✅ Atributo lang configurado corretamente"
else
    echo "❌ Atributo lang não encontrado ou incorreto"
    VALIDATION_PASSED=false
fi

# Verificar título
if grep -q "<title>DevOps Essentials</title>" "$HTML_FILE"; then
    echo "✅ Título da página presente"
else
    echo "❌ Título da página não encontrado"
    VALIDATION_PASSED=false
fi

# Verificar meta charset
if grep -q 'charset="UTF-8"' "$HTML_FILE"; then
    echo "✅ Meta charset UTF-8 presente"
else
    echo "❌ Meta charset UTF-8 não encontrado"
    VALIDATION_PASSED=false
fi

# Verificar viewport
if grep -q 'name="viewport"' "$HTML_FILE"; then
    echo "✅ Meta viewport presente"
else
    echo "❌ Meta viewport não encontrado"
    VALIDATION_PASSED=false
fi

# Verificar CSS link
if grep -q 'href="/static/css/main.css"' "$HTML_FILE"; then
    echo "✅ Link para CSS principal presente"
else
    echo "❌ Link para CSS principal não encontrado"
    VALIDATION_PASSED=false
fi

# Verificar conteúdo principal
if grep -q "Trilha DevOps" "$HTML_FILE"; then
    echo "✅ Conteúdo 'Trilha DevOps' presente"
else
    echo "❌ Conteúdo 'Trilha DevOps' não encontrado"
    VALIDATION_PASSED=false
fi

if grep -q "Trilha Containers" "$HTML_FILE"; then
    echo "✅ Conteúdo 'Trilha Containers' presente"
else
    echo "❌ Conteúdo 'Trilha Containers' não encontrado"
    VALIDATION_PASSED=false
fi

# Verificar links dos cursos
if grep -q "4linux.com.br" "$HTML_FILE"; then
    echo "✅ Links para cursos da 4Linux presentes"
else
    echo "❌ Links para cursos da 4Linux não encontrados"
    VALIDATION_PASSED=false
fi

# Verificar estrutura HTML básica
if grep -q "<html" "$HTML_FILE" && grep -q "<head>" "$HTML_FILE" && grep -q "<body>" "$HTML_FILE"; then
    echo "✅ Estrutura HTML básica presente"
else
    echo "❌ Estrutura HTML básica incompleta"
    VALIDATION_PASSED=false
fi

# Resultado final
echo ""
if [ "$VALIDATION_PASSED" = true ]; then
    echo "🎉 Todas as validações passaram! HTML está válido."
    exit 0
else
    echo "💥 Algumas validações falharam. Verifique o HTML."
    exit 1
fi