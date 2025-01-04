import { expandGlob } from '@std/fs';
import { dirname, basename, join } from '@std/path';

const IV_SIZE = 96 / 8; // 96 bytes / 8 bytes per value
const SALT_SIZE = 128 / 8; // 128 bytes / 8 bytes per value
const KEY_LENGTH = 256;

function importPassword(password: string) {
  return crypto.subtle.importKey('raw', new TextEncoder().encode(password), { name: 'PBKDF2' }, false, [
    'deriveBits',
    'deriveKey'
  ]);
}

function deriveKey(baseKey: CryptoKey, salt: Uint8Array) {
  return crypto.subtle.deriveKey(
    {
      name: 'PBKDF2',
      salt,
      iterations: 100000,
      hash: 'SHA-256'
    },
    baseKey,
    { name: 'AES-GCM', length: KEY_LENGTH },
    true,
    ['encrypt', 'decrypt']
  );
}

async function encryptInputs(password: string) {
  const inputs = await Array.fromAsync(expandGlob('../src/**/*.txt'));
  const baseKey = await importPassword(password);

  console.log('Found', inputs.length, 'files');

  for (const { path } of inputs) {
    console.log('Currently reading:', path);

    const contents = new TextEncoder().encode(Deno.readTextFileSync(path));

    if (contents.length === 0) {
      console.log('Empty file, skipping');
      continue;
    }

    const salt = crypto.getRandomValues(new Uint8Array(SALT_SIZE));
    const iv = crypto.getRandomValues(new Uint8Array(IV_SIZE));
    const key = await deriveKey(baseKey, salt);

    const encryptedData = new Uint8Array(await crypto.subtle.encrypt({ name: 'AES-GCM', iv }, key, contents));

    const outputPath = join(dirname(path), basename(path).split('.')[0] + '.bin');
    const outputData = new Uint8Array(salt.length + iv.length + encryptedData.length);
    outputData.set(salt);
    outputData.set(iv, salt.length);
    outputData.set(encryptedData, salt.length + iv.length);

    Deno.writeFileSync(outputPath, outputData);
  }
}

async function decryptInputs(password: string) {
  const inputs = await Array.fromAsync(expandGlob('../src/**/*.bin'));
  const baseKey = await importPassword(password);

  console.log('Found', inputs.length, 'files');

  for (const { path } of inputs) {
    console.log('Currently reading:', path);

    const contents = Deno.readFileSync(path);

    const salt = contents.slice(0, SALT_SIZE);
    const iv = contents.slice(SALT_SIZE, SALT_SIZE + IV_SIZE);
    const key = await deriveKey(baseKey, salt);

    const inputData = contents.slice(SALT_SIZE + IV_SIZE);
    const decryptedData = await crypto.subtle.decrypt({ name: 'AES-GCM', iv }, key, inputData);

    const outputPath = join(dirname(path), basename(path).split('.')[0] + '.txt');
    Deno.writeTextFileSync(outputPath, new TextDecoder().decode(new Uint8Array(decryptedData)));
  }
}

const [mode, password] = Deno.args;
switch (mode) {
  case 'encrypt':
    encryptInputs(password);
    break;

  case 'decrypt':
    decryptInputs(password);
    break;

  default:
    console.log('Usage: crypto <encrypt | decrypt> <password>');
    break;
}
