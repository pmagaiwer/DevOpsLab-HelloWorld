# Use a imagem oficial do Python
FROM python:3.10.7-slim

# Definir o diretório de trabalho no container
WORKDIR /app

# Copiar os arquivos de requirements primeiro (para aproveitar o cache do Docker)
COPY requirements.txt .

# Instalar as dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o código da aplicação
COPY . .

# Expor a porta 5000
EXPOSE 5000

# Comando para executar a aplicação
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]