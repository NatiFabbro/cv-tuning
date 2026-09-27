#!/usr/bin/env node
// Chequeos previos a un release. Uso:  node tools/check-release.mjs [--release]
// Sin --release avisa (warning) de lo que solo bloquea un release; con --release falla.
// Verifica las reglas de diseño del repo. `claude plugin validate --strict` se corre aparte.

import { readFileSync, readdirSync, lstatSync, existsSync } from 'node:fs';
import { join, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = join(fileURLToPath(import.meta.url), '..', '..');
const releaseMode = process.argv.includes('--release');
const errors = [];
const warnings = [];
const fail = (m) => errors.push(m);
const warn = (m) => (releaseMode ? errors : warnings).push(m);
const rel = (p) => relative(root, p).split(sep).join('/');

const readJson = (p) => JSON.parse(readFileSync(join(root, p), 'utf8'));

function walk(dir, out = []) {
  for (const name of readdirSync(dir)) {
    if (name === '.git' || name === 'node_modules') continue;
    const p = join(dir, name);
    const st = lstatSync(p);
    if (st.isSymbolicLink()) fail(`Symlink no permitido: ${rel(p)}`);
    else if (st.isDirectory()) walk(p, out);
    else out.push(p);
  }
  return out;
}

// 1. Versiones iguales en plugin.json y marketplace.json
const marketplace = readJson('.claude-plugin/marketplace.json');
const plugin = readJson('plugins/cv/.claude-plugin/plugin.json');
const entry = marketplace.plugins.find((p) => p.name === plugin.name);
if (!entry) fail(`marketplace.json no lista el plugin "${plugin.name}"`);
else if (entry.version !== plugin.version)
  fail(`Versiones distintas: marketplace=${entry.version} plugin=${plugin.version}`);

// 2. Paths de manifiesto con "/" y dentro de plugins/cv/
if (entry && (entry.source.includes('\\') || !entry.source.startsWith('./plugins/cv')))
  fail(`source del plugin inválido: ${entry.source}`);

// 3. CHANGELOG tiene la versión (o Unreleased, que solo se acepta fuera de release)
const changelog = readFileSync(join(root, 'CHANGELOG.md'), 'utf8');
if (!changelog.includes(`## [${plugin.version}]`)) {
  if (changelog.includes('## [Unreleased]'))
    warn(`CHANGELOG solo tiene [Unreleased]; falta la sección [${plugin.version}]`);
  else fail(`CHANGELOG sin sección para ${plugin.version}`);
}

// 4. Symlinks y contenido de plugins/cv/
const pluginFiles = walk(join(root, 'plugins/cv'));
const textExt = /\.(md|json|txt|ps1|mjs|js)$/;
const absPath = /(^|[\s"'(`=])([A-Za-z]:\\|\/Users\/|\/home\/|\/sessions\/|\/mnt\/)[^\s"'`)]*/m;
for (const f of pluginFiles) {
  if (!textExt.test(f)) continue;
  const text = readFileSync(f, 'utf8');
  if (absPath.test(text)) fail(`Ruta absoluta en ${rel(f)}`);
}

// 5. Skills: frontmatter con name y description; sin bloque de diagnóstico temporal en release
const skillsDir = join(root, 'plugins/cv/skills');
for (const s of readdirSync(skillsDir)) {
  const p = join(skillsDir, s, 'SKILL.md');
  if (!existsSync(p)) { fail(`Falta SKILL.md en skills/${s}`); continue; }
  const text = readFileSync(p, 'utf8');
  const fm = text.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!fm) { fail(`Sin frontmatter: ${rel(p)}`); continue; }
  if (!/^name:\s*\S+/m.test(fm[1])) fail(`Sin name en ${rel(p)}`);
  if (!/^description:\s*\S+/m.test(fm[1])) fail(`Sin description en ${rel(p)}`);
  if (/## Diagnóstico \(temporal/.test(text))
    warn(`Bloque "Diagnóstico (temporal)" todavía presente en ${rel(p)}`);
}

// 5b. Plantillas y contratos que los skills referencian existen
for (const f of [
  'reference/workspace-layout.md', 'reference/profile-schema.md', 'reference/honesty-rules.md',
  'reference/ats-guidelines.md', 'reference/postulaciones-format.md', 'reference/locales.md',
  'reference/template-styles.md', 'reference/cv-structure.md', 'reference/external-links.md',
  'reference/voz-y-persona.md', 'assets/templates/ats-clean.docx', 'assets/templates/visual.docx',
]) if (!existsSync(join(root, 'plugins/cv', f))) fail(`Falta plugins/cv/${f}`);

// 6. Nada de datos personales evidentes en el repo: emails fuera de example.com
for (const f of walk(root)) {
  if (!textExt.test(f) || rel(f).startsWith('tools/')) continue;
  const emails = readFileSync(f, 'utf8').match(/[\w.+-]+@[\w-]+\.[\w.-]+/g) ?? [];
  for (const e of emails)
    if (!/@example\.(com|org|net)$/i.test(e) && !/^noreply@/i.test(e)) fail(`Email real posible en ${rel(f)}: ${e}`);
}

for (const w of warnings) console.log(`AVISO  ${w}`);
for (const e of errors) console.log(`ERROR  ${e}`);
console.log(errors.length
  ? `\n${errors.length} error(es).`
  : `\nOK: versión ${plugin.version}${warnings.length ? ` (${warnings.length} aviso(s) que bloquearían un release)` : ''}.`);
process.exit(errors.length ? 1 : 0);
