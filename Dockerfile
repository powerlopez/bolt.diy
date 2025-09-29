FROM node:20-bookworm-slim

# Instalar dependencias del sistema
RUN apt-get update && \
    apt-get install -y git python3 make g++ && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instalar pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copiar archivos de dependencias
COPY package.json pnpm-lock.yaml* ./

# Instalar dependencias
RUN pnpm install --frozen-lockfile

# Copiar el resto del código
COPY . .

# Exponer puerto
EXPOSE 5173

# Variables de entorno
ENV HOST=0.0.0.0
ENV PORT=5173
ENV NODE_ENV=development

# Comando de inicio
CMD ["pnpm", "run", "dev", "--host", "0.0.0.0"]
