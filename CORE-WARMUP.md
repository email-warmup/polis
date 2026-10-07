# Форк для Core Warmup

Ветка `core-warmup` — форк `@boxyhq/saml-jackson` (Ory Polis) от тега `v26.2.0` для проекта [email-warmup/core-warmup](https://github.com/email-warmup/core-warmup).

## Что изменено (`npm/`)

1. **Безопасность зависимостей:** обновлены `@boxyhq/metrics` 0.3.0, `@boxyhq/saml20` 1.20.1, `axios` 1.20.0, `lodash` 4.18.1, `node-forge` 1.4.0, `typeorm` 0.3.31, `jose`, `openid-client`, `pg`, `ipaddr.js` (patch/minor).
2. **Только PostgreSQL:** драйверы других БД перенесены в опциональные `peerDependencies` и по умолчанию не устанавливаются:
   - `mssql`, `mysql2`, `better-sqlite3` — их загружает сам TypeORM только для своего `type`;
   - `mongodb`, `redis`, `@aws-sdk/*` — в `src/db/db.ts` импортируются динамически, только для движков `mongo`, `redis` и `dynamodb`.
   Чтобы использовать другой движок, установите соответствующий драйвер рядом с пакетом.

## Проверка

```bash
cd npm && npm install && npm run build
POLIS_NO_ANALYTICS=1 npx tap --disable-coverage test/sso/*.test.ts test/identity-federation/*.test.ts test/sso-traces/*.test.ts test/dsync/*.test.ts test/event/*.test.ts
```

Результат на `26.2.0-cw.2`: 818/818. `test/setup-link.test.ts` падает и в исходном `v26.2.0` (проблема upstream, не связана с форком).

## Выпуск версии

```bash
cd npm
npm pkg set version=26.2.0-cw.N
./pack-core-warmup.sh ..   # сборка + main/types → dist (как в upstream-публикации)
gh release create v26.2.0-cw.N boxyhq-saml-jackson-26.2.0-cw.N.tgz -R email-warmup/polis --target core-warmup
```

В `core-warmup/web/package.json` зависимость указывает на tarball из GitHub Release.
