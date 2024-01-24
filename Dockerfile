FROM public.ecr.aws/lambda/nodejs:18 AS builder
WORKDIR /app
COPY ./src ./
COPY ./package.json ./
RUN npm install
RUN npx next build

FROM public.ecr.aws/lambda/nodejs:18
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY index.js ./index.js
CMD [ "index.handler" ]
