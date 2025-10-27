#!/bin/sh
# chatGPT para Kindle Paperwhite
# 1.0, Roni Bandini, Octubre de 2025

# Settings
API_KEY=""
MODEL="gpt-3.5-turbo"
API_URL="https://api.openai.com/v1/chat/completions"
TEMP_FILE="/tmp/openai_response.json"

clear
echo "============================================="
echo "chatGPT para Kindle Paperwhite"
echo "Roni Bandini - Octubre de 2025 - Argentina"
echo "============================================="
echo "Para salir 'quit'"

echo ""

while true; do
    # Leer pregunta
    printf "Vos: "
    read USER_PROMPT

    # Salir si el usuario escribe quit
    if [ "$USER_PROMPT" = "quit" ]; then
        echo "Saliendo..."
        break
    fi

    # Llamada al API y guardar JSON completo
    curl -s -X POST "$API_URL" \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $API_KEY" \
      -d '{"model":"'"$MODEL"'","messages":[{"role":"user","content":"'"$USER_PROMPT"'"}]}' \
      > "$TEMP_FILE" 2>/dev/null

    # Extraer respuesta del json (con las herramientas disponibles que no son muchas)
    RESPONSE=$(grep '"content":' "$TEMP_FILE" \
        | head -n1 \
        | sed 's/^[ \t]*"content": "//' \
        | sed 's/", *"refusal":.*//' \
        | sed 's/\\n/\n/g' \
        | sed 's/\\"/"/g')

    # Mostrar la respuesta
    echo "chatGPT: $RESPONSE"
    echo ""
done

# Limpiar archivo temporal
rm -f "$TEMP_FILE"
