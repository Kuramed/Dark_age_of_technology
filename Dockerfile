# Usar a imagem oficial do Node.js
FROM node:20-alpine

# Instalar o OpenSSL exigido pelo Prisma no Alpine Linux
RUN apk add --no-cache openssl

# Definir o diretório de trabalho dentro do contentor
WORKDIR /usr/src/app

# Copiar os ficheiros de dependências
COPY package*.json ./
COPY prisma ./prisma/

# Instalar as dependências e gerar o cliente Prisma
RUN npm install
RUN npx prisma generate

# Copiar o resto do código
COPY . .

# Construir a aplicação NestJS
RUN npm run build

# Expor a porta 3000
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "run", "start:dev"]