FROM node:20-alpine

RUN apk add --no-cache git python3 make g++

WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml* ./

RUN pnpm install --frozen-lockfile

COPY . .

EXPOSE 5173

ENV HOST=0.0.0.0
ENV PORT=5173
ENV NODE_ENV=development

CMD ["pnpm", "run", "dev", "--host", "0.0.0.0"]
