# 1) Confirm we’re in the expected home + app dir
#1759172814
whoami
#1759172814
pwd
#1759172814
ls -la
#1759172814
# 2) Most reliable: Apache/domain error logs (cPanel mirrors Passenger errors here)
#1759172814
# Try the generic error_log:
#1759172814
tail -n 200 ~/logs/error_log 2>/dev/null
#1759172814
# Try any domain-specific error logs (many cPanel setups name them like this):
#1759172814
tail -n 200 ~/logs/*error*log* 2>/dev/null
#1759172814
# 3) Some cPanel builds keep Node app logs under ~/nodejs
#1759172814
ls -la ~/nodejs 2>/dev/null || true
#1759172814
ls -la ~/nodejs/kci-api 2>/dev/null || true
#1759172814
tail -n 200 ~/nodejs/kci-api/*.log 2>/dev/null || true
#1759172814
# 4) Hunt for anything "passenger" in your logs folder
#1759172814
grep -iR "passenger" ~/logs 2>/dev/null | tail -n 80
#1759172814
# 5) Broad find for likely files (shallow so it’s fast)
#1759172814
find ~ -maxdepth 3 -type f \( -iname "*error*log*" -o -iname "passenger*.log" -o -iname "*passenger*" \) -printf "%p\n" 2>/dev/null
#1759174459
# A) See the last 200 lines (often enough)
#1759174459
tail -n 200 ~/logs/kci-api-passenger.log
#1759174682
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759174682
cd ~/kci-api
#1759174682
# install deps then build (use whichever works in your package.json)
#1759174682
npm ci || npm install
#1759174686
npm run build || npx tsc -p tsconfig.build.json
#1759174979
# already: source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759174979
cd ~/kci-api
#1759174979
# 1) Install the compiler locally to this project
#1759174979
npm install --save-dev typescript @types/node
#1759174982
# (If your cPanel has NODE_ENV=production and it skipped devDeps, force it:)
#1759174982
# npm install --production=false
#1759174982
# 2) Build using your tsconfig.build.json
#1759174982
npx tsc -p tsconfig.build.json
#1759174985
# 3) Confirm the compiled entry exists
#1759174985
ls -la dist/index.js
#1759175186
# still inside the Node env: source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759175186
cd ~/kci-api
#1759175186
# 1) Confirm where global modules live and whether TS is present
#1759175186
npm root -g
#1759175187
npm ls typescript || true
#1759175188
# 2) Install the compiler globally into THIS node env (safe & common on cPanel)
#1759175188
npm i -g typescript
#1759175190
# 3) Compile using the *explicit* compiler path (avoids the bad "tsc" package)
#1759175190
TSBIN="$(npm root -g)/typescript/bin/tsc"
#1759175191
node "$TSBIN" -p tsconfig.build.json
#1759175382
# Check module type:
#1759175382
grep -i '"type"' package.json || echo 'no "type" field'
#1759175670
# 1) Build TS → JS WITHOUT needing local node_modules:
#1759175670
#    This downloads TypeScript to a temp cache and runs it.
#1759175670
npx --yes -p typescript@5.4.5 tsc -p tsconfig.build.json
#1759175689
# 2) Verify build output exists
#1759175689
ls -la dist/index.js
#1759175689
# 3) Create a tiny bootstrap that loads the built file (ESM project)
#1759175689
printf "import('./dist/index.js');\n" > ~/kci-api/bootstrap.mjs
#1759175689
# 4) Make sure your server binds correctly for Passenger
#1759175689
#    (your compiled code should reflect this; if needed, update src then rebuild)
#1759175689
#    const port = Number(process.env.PORT) || 0;
#1759175689
#    const host = process.env.HOST || '127.0.0.1';
#1759175689
#    await app.listen({ port, host });
#1759175689
# 5) (Optional sanity) Manual run to prove the server boots:
#1759175689
PORT=4010 NODE_ENV=production node dist/index.js &
#1759175689
sleep 1
#1759175690
curl -i http://127.0.0.1:4010/healthz || true
#1759175742
kill %1 2>/dev/null || true
#1759175893
tail -n 150 ~/logs/kci-api-passenger.log
#1759214728
cd kci-repo
#1759214740
npm install --include=dev
#1759215158
cd ~/kci-api
#1759215165
node -v
#1759215177
npm -v
#1759215229
node -v
#1759215546
source /home/komuni60/nodevenv/kci-api/20/bin/activate && cd /home/komuni60/kci-api
#1759215566
npm install --include=dev
#1759215583
npm --workspace apps-api run build
#1759215985
pwd                     # should print /home/komuni60/kci-api
#1759215985
ls package.json         # make sure this file exists
#1759215985
npm -v                  # verify npm ≥ 7 so workspaces are supported
#1759216049
npm run build --workspace apps-api
#1759216493
cd /home/komuni60/kci-api
#1759216508
npm --workspace apps-api run build
#1759218134
/home/komuni60/kci-repo
#1759218141
cd /home/komuni60/kci-repo
#1759218150
npm install --include=dev
#1759218168
npm --workspace apps-api run build
#1759221030
source /home/komuni60/nodevenv/kci-repo/20/bin/activate && cd /home/komuni60/kci-repo
#1759221054
npm install --include=dev
#1759221069
npm --workspace apps-api run build
#1759222059
source /home/komuni60/nodevenv/kci-repo/apps/api/20/bin/activate && cd /home/komuni60/kci-repo/apps/api
#1759222074
cd ~/kci-repo/apps/api
#1759222093
npm install
#1759222259
tail -n 80 /home/komuni60/logs/kci-api-passenger.log
#1759223057
source /home/komuni60/nodevenv/kci-repo/apps/api/20/bin/activate
#1759223057
cd /home/komuni60/kci-repo/apps/api
#1759223057
# install dev deps so the TypeScript build can run
#1759223057
npm install --include=dev
#1759223064
# compile TS -> JS
#1759223064
npm run build
#1759223078
# must exist:
#1759223078
ls -la dist/index.js
#1759223078
# optional but helpful: force Passenger reload without UI
#1759223078
mkdir -p tmp && touch tmp/restart.txt
#1759223078
deactivate
#1759226601
source ~/nodevenv/kci-api/20/bin/activate
#1759226601
cd ~/kci-api
#1759226601
npm install --include=dev
#1759226619
npm run build
#1759226642
deactivate
#1759227296
cp ~/kci-repo/tsconfig.base.json ~/kci-api/tsconfig.base.json
#1759227377
source ~/nodevenv/kci-api/20/bin/activate
#1759227377
cd ~/kci-api
#1759227377
npm install --include=dev
#1759227380
npm run build
#1759227392
deactivate
#1759227680
tail -n 200 /home/komuni60/logs/kci-api-passenger.log
#1759227759
PassengerAppRoot "/home/komuni60/kci-api"
#1759227759
PassengerStartupFile server.mjs
#1759227759
PassengerNodejs "/home/komuni60/nodevenv/kci-api/20/bin/node"
#1759227771
tail -n 200 /home/komuni60/logs/kci-api-passenger.log
#1759227860
source ~/nodevenv/kci-api/20/bin/activate
#1759227860
cd ~/kci-api
#1759227860
npm install --include=dev
#1759227865
npm run build
#1759227877
deactivate
#1759227910
tail -n 200 /home/komuni60/logs/kci-api-passenger.log
#1759229950
cd /home/komuni60/kci-api
#1759229961
npm install && npm run build
#1759229973
source ~/nodevenv/kci-api/20/bin/activate
#1759229977
[komuni60@ankama kci-api]$ cd /home/komuni60/kci-api
#1759229977
[komuni60@ankama kci-api]$ npm install && npm run build
#1759229977
bash: npm: command not found
#1759230150
[komuni60@ankama kci-api]$source ~/nodevenv/kci-api/20/bin/activate
#1759230165
deactivate
#1759230167
source ~/nodevenv/kci-api/20/bin/activate
#1759230177
which node
#1759230177
which npm
#1759230194
cd ~/kci-api
#1759230194
npm install
#1759230197
npm run build
#1759230464
npm install --include=dev
#1759230485
ls node_modules/.bin/tsc
#1759230496
npm run build
#1759231826
npm install --include=dev
#1759231846
npm run build
#1759233203
# 0) Enter env and go to app
#1759233203
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759233203
cd ~/kci-api
#1759233203
# 1) Make sure the prod entry only loads the build (NO tsx)
#1759233203
#    Overwrite server.mjs to be a simple ESM bootstrap:
#1759233203
cat > server.mjs <<'EOF'
import './dist/index.js';
EOF

#1759233203
# (Optional) keep server.js for local dev only; Passenger will not use it.
#1759233203
# 2) Make the app respect Passenger's PORT without refactoring everything:
#1759233203
#    Edit src/index.ts to prefer process.env.PORT/HOST when present.
#1759233203
#    This replaces the single listen(...) line with a runtime-aware one.
#1759233203
# Create a backup
#1759233203
cp src/index.ts src/index.ts.bak
#1759233203
# Replace the listen call
#1759233203
# (the pattern matches the original one-liner in your repo)
#1759233203
perl -0777 -pe "s/await server\.listen\(\{\s*port:\s*env\.server\.port,\s*host:\s*env\.server\.host\s*\}\);/const port = Number(process.env.PORT || env.server.port);\n  const host = process.env.HOST || env.server.host || '127.0.0.1';\n  await server.listen({ port, host });/s" -i src/index.ts
#1759233203
# 3) Install deps (include dev) and compile to dist/
#1759233203
npm install --include=dev
#1759233206
# Belt-and-suspenders: install the compiler in this nodeenv so 'tsc' is guaranteed:
#1759233206
npm i -g typescript
#1759233209
node "$(npm root -g)/typescript/bin/tsc" -p tsconfig.build.json
#1759233210
# Verify build exists
#1759233210
ls -l dist/index.js
#1759233210
# 4) Ensure data directory exists & is private
#1759233210
mkdir -p ~/kci-api/data
#1759233210
chmod 700 ~/kci-api/data
#1759233210
# 5) In cPanel → Setup Node.js App, set:
#1759233210
#    - Application root: /home/komuni60/kci-api
#1759233210
#    - Startup file:     server.mjs
#1759233210
#    - Node version:     20.x
#1759233210
#    - Env vars:
#1759233210
#         NODE_ENV=production
#1759233210
#         DATA_DIR=/home/komuni60/kci-api/data
#1759233210
# 6) Restart Passenger and check fresh logs
#1759233210
mkdir -p tmp && touch tmp/restart.txt
#1759233210
sleep 3
#1759233213
tail -n 200 ~/logs/kci-api-passenger.log
#1759233489
# should contain exactly ONE line:
#1759233489
# import './dist/index.js';
#1759233489
sed -n '1,5p' ~/kci-api/server.mjs
#1759233526
cd ~/kci-api
#1759233526
mkdir -p tmp && touch tmp/restart.txt
#1759233526
sleep 3
#1759233529
tail -n 80 ~/logs/kci-api-passenger.log
#1759233748
tail -n 120 ~/logs/kci-api-passenger.log
#1759233847
grep -n "server.listen" -n ~/kci-api/dist/index.js | head
#1759233907
cd ~/kci-api
#1759233907
touch tmp/restart.txt
#1759233907
sleep 3
#1759233910
tail -n 120 ~/logs/kci-api-passenger.log
#1759234202
cd ~/kci-api
#1759234202
ls -l server.mjs
#1759234202
sed -n '1,5p' server.mjs
#1759234250
# backup
#1759234250
cp dist/index.js dist/index.js.bak
#1759234250
# replace the listen call in the compiled file
#1759234250
perl -0777 -pe 's/await server\.listen\(\{\s*port:\s*env\.server\.port,\s*host:\s*env\.server\.host\s*\}\);/const port=Number(process.env.PORT||env.server.port);const host=process.env.HOST||env.server.host||"127.0.0.1";await server.listen({ port, host });/s' -i dist/index.js
#1759234316
mkdir -p /home/komuni60/nodevenv/kci-api/apps/api/20/bin
#1759234316
ln -sf /home/komuni60/nodevenv/kci-api/20/bin/node /home/komuni60/nodevenv/kci-api/apps/api/20/bin/node
#1759234343
cd ~/kci-api
#1759234343
mkdir -p tmp && touch tmp/restart.txt
#1759234343
sleep 3
#1759234346
tail -n 120 ~/logs/kci-api-passenger.log
#1759234805
# Touch restart just to be sure (after the app is created/started)
#1759234805
cd ~/kci-api
#1759234805
mkdir -p tmp && touch tmp/restart.txt
#1759234805
sleep 3
#1759234808
tail -n 120 ~/logs/kci-api-passenger.log
#1759235224
# 1) Confirm the Node app config (in cPanel) is:
#1759235224
#    Application root:  kci-api
#1759235224
#    Startup file:      dist/index.js
#1759235224
#    Node version:      20
#1759235224
#    Env vars:          NODE_ENV=production, DATA_DIR=/home/komuni60/kci-api/data
#1759235224
# 2) Remove the temporary symlink hack we made earlier (optional now that it’s working)
#1759235224
rm -f /home/komuni60/nodevenv/kci-api/apps/api/20/bin/node
#1759235224
rmdir /home/komuni60/nodevenv/kci-api/apps/api/20/bin 2>/dev/null || true
#1759235224
rmdir /home/komuni60/nodevenv/kci-api/apps/api/20 2>/dev/null || true
#1759235224
rmdir -p /home/komuni60/nodevenv/kci-api/apps 2>/dev/null || true
#1759235224
# 3) We’re not using server.mjs anymore; rename so no one points to it by mistake
#1759235224
mv ~/kci-api/server.mjs ~/kci-api/server.mjs.dev
#1759235224
# 4) Make sure source uses Passenger’s PORT going forward, then rebuild once
#1759235224
cd ~/kci-api
#1759235224
# (you already patched src/index.ts; this rebuild makes dist match the source)
#1759235224
./node_modules/.bin/tsc -p tsconfig.build.json
#1759235224
# 5) Restart Passenger to get fresh log lines
#1759235224
mkdir -p tmp && touch tmp/restart.txt
#1759235224
sleep 3
#1759235227
tail -n 80 ~/logs/kci-api-passenger.log
#1759235545
cd ~/kci-api
#1759235570
source /home/komuni60/nodevenv/kci-api/20/bin/activate && cd /home/komuni60/kci-api
#1759235581
# 1) Confirm the Node app config (in cPanel) is:
#1759235581
#    Application root:  kci-api
#1759235581
#    Startup file:      dist/index.js
#1759235581
#    Node version:      20
#1759235581
#    Env vars:          NODE_ENV=production, DATA_DIR=/home/komuni60/kci-api/data
#1759235581
# 2) Remove the temporary symlink hack we made earlier (optional now that it’s working)
#1759235581
rm -f /home/komuni60/nodevenv/kci-api/apps/api/20/bin/node
#1759235581
rmdir /home/komuni60/nodevenv/kci-api/apps/api/20/bin 2>/dev/null || true
#1759235581
rmdir /home/komuni60/nodevenv/kci-api/apps/api/20 2>/dev/null || true
#1759235581
rmdir -p /home/komuni60/nodevenv/kci-api/apps 2>/dev/null || true
#1759235581
# 3) We’re not using server.mjs anymore; rename so no one points to it by mistake
#1759235581
mv ~/kci-api/server.mjs ~/kci-api/server.mjs.dev
#1759235581
# 4) Make sure source uses Passenger’s PORT going forward, then rebuild once
#1759235581
cd ~/kci-api
#1759235581
# (you already patched src/index.ts; this rebuild makes dist match the source)
#1759235581
./node_modules/.bin/tsc -p tsconfig.build.json
#1759235581
# 5) Restart Passenger to get fresh log lines
#1759235581
mkdir -p tmp && touch tmp/restart.txt
#1759235581
sleep 3
#1759235584
tail -n 80 ~/logs/kci-api-passenger.log
#1759235601
# Should show your app’s own “listening” log line with a new timestamp
#1759235601
grep -i "listening" ~/logs/kci-api-passenger.log | tail -n 3
#1759235601
# Hit a few endpoints
#1759235601
curl -sS https://api.komunitaschineseindonesia.com/healthz
#1759235603
curl -sS https://api.komunitaschineseindonesia.com/api
#1759239494
cd ~/kci-api
#1759239494
cat > scripts/create-admin.ts <<'EOF'
import { fileURLToPath } from 'url';
import path from 'path';

// Adjust this import only if your service file exports a different name:
import { AuthService } from './src/modules/auth/service';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function main() {
  const email = process.argv[2];
  const name  = process.argv[3] || 'Admin';
  const pass  = process.argv[4];
  if (!email || !pass) {
    console.error('Usage: tsx scripts/create-admin.ts <email> <name?> <password>');
    process.exit(1);
  }
  await AuthService.createAdmin({ email, name, password: pass });
  console.log
admin@komunitaschineseindonesia.com, admin, suksesjayasukses

#1759239733
# 1) If the prompt is "stuck" waiting for EOF, press Ctrl+C once to cancel.
#1759239733
# 2) Recreate the script with correct contents (overwrites any partial file)
#1759239733
cd ~/kci-api
#1759239733
cat > scripts/create-admin.ts <<'EOF'
import { AuthService } from './src/modules/auth/service';

async function main() {
  const email = process.argv[2];
  const name  = process.argv[3] || 'Admin';
  const pass  = process.argv[4];
  if (!email || !pass) {
    console.error('Usage: tsx scripts/create-admin.ts <email> <name?> <password>');
    process.exit(1);
  }
  await AuthService.createAdmin({ email, name, password: pass });
  console.log('Admin created:', email);
}
main().catch((e) => { console.error(e); process.exit(1); });
EOF

#1759239942
cd ~/kci-api
#1759239942
cat > create-admin.ts <<'EOF'
import { AuthService } from './src/modules/auth/service';

async function main() {
  const email = process.argv[2];
  const name  = process.argv[3] || 'Admin';
  const pass  = process.argv[4];
  if (!email || !pass) {
    console.error('Usage: tsx create-admin.ts <email> <name?> <password>');
    process.exit(1);
  }
  await AuthService.createAdmin({ email, name, password: pass });
  console.log('Admin created:', email);
}
main().catch((e) => { console.error(e); process.exit(1); });
EOF

#1759239954
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759239954
npx tsx create-admin.ts admin@komunitaschineseindonesia.com "Admin" "suksesjayasukses"
#1759240103
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759240106
npx tsx create-admin.ts admin@komunitaschineseindonesia.com "Admin" "suksesjayasukses"
#1759240312
deactivate
#1759240315
grep -Rni "bcrypt"  ~/kci-api/src/modules/auth || true
#1759240315
grep -Rni "argon2"  ~/kci-api/src/modules/auth || true
#1759240435
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759240435
cd ~/kci-api
#1759240435
npm install bcryptjs --save
#1759240437
node -e "const fs=require('fs');const p='/home/komuni60/kci-data/db/admins.json';const bcrypt=require('bcryptjs');const email='admin@komunitaschineseindonesia.com';const name='Admin';const pass='suksesjayasukses';let data=[];try{data=JSON.parse(fs.readFileSync(p,'utf8'));}catch(e){if(e.code!=='ENOENT')throw e;}const hashed=bcrypt.hashSync(pass,10);const now=new Date().toISOString();const i=data.findIndex(x=>x.email===email);const rec={id:Date.now().toString(36),email,name,role:'admin',passwordHash:hashed,createdAt:now,updatedAt:now};if(i>=0){data[i]={...data[i],...rec};}else{data.push(rec);}fs.mkdirSync('/home/komuni60/kci-data/db',{recursive:true});fs.writeFileSync(p,JSON.stringify(data,null,2));console.log('OK wrote',p)"
#1759240438
deactivate
#1759240484
cat /home/komuni60/kci-data/db/admins.json
#1759241178
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759241178
cd ~/kci-api
#1759241178
npm install bcryptjs --save
#1759241184
node -e "const fs=require('fs');const crypto=require('crypto');const bcrypt=require('bcryptjs');const p='/home/komuni60/kci-data/db/admins.json';const email='admin@komunitaschineseindonesia.com';const name='Admin';const pass='suksesjayasukses';let data=[];try{data=JSON.parse(fs.readFileSync(p,'utf8'));}catch(e){if(e.code!=='ENOENT')throw e;}const now=new Date().toISOString();const salt=crypto.randomBytes(16).toString('hex');const pbkdf2=crypto.pbkdf2Sync(pass,salt,10000,64,'sha512').toString('hex');const rec={ id:Date.now().toString(36), email, name, full_name:name, role:'owner', passwordHash:bcrypt.hashSync(pass,10), password_hash:`${salt}:${pbkdf2}`, createdAt:now, updatedAt:now};const i=data.findIndex(x=>x.email===email);if(i>=0){data[i]={...data[i],...rec};}else{data.push(rec);}fs.mkdirSync('/home/komuni60/kci-data/db',{recursive:true});fs.writeFileSync(p,JSON.stringify(data,null,2));console.log('OK wrote',p)"
#1759241185
deactivate
#1759241185
# sanity check
#1759241185
cat /home/komuni60/kci-data/db/admins.json
#1759241220
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759241318
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/x-www-form-urlencoded'   --data 'email=admin@komunitaschineseindonesia.com&password=suksesjayasukses'
#1759241847
cd ~/kci-api
#1759241847
mkdir -p tools
#1759241847
cat > tools/upsert-admin.js <<'EOF'
const fs = require('fs');
const crypto = require('crypto');
const bcrypt = require('bcryptjs');

const PATH = '/home/komuni60/kci-data/db/admins.json';
const email = process.argv[2];
const name  = process.argv[3] || 'Admin';
const pass  = process.argv[4];
if (!email || !pass) {
  console.error('Usage: node tools/upsert-admin.js <email> <name?> <password>');
  process.exit(1);
}

let data = [];
try { data = JSON.parse(fs.readFileSync(PATH, 'utf8')); } catch (e) {
  if (e.code !== 'ENOENT') throw e;
}

const salt = crypto.randomBytes(16).toString('hex');
const pb   = crypto.pbkdf2Sync(pass, salt, 10000, 64, 'sha512').toString('hex'); // 10k, sha512, 64B
const now  = new Date().toISOString();

const rec = {
  id: Date.now(),
  email,
  full_name: name,
  role: 'owner',
  // support both schemes:
  password_hash: `${salt}:${pb}`,         // legacy (salt:pbkdf2)
  passwordHash: bcrypt.hashSync(pass,10), // bcrypt
  createdAt: now,
  updatedAt: now
};

const i = data.findIndex(a => a.email === email);
if (i >= 0) data[i] = { ...data[i], ...rec };
else data.push(rec);

fs.mkdirSync('/home/komuni60/kci-data/db', { recursive: true });
fs.writeFileSync(PATH, JSON.stringify(data, null, 2));
console.log('Wrote', PATH);
EOF

#1759241847
# run it
#1759241847
node tools/upsert-admin.js admin@komunitaschineseindonesia.com "Admin" "suksesjayasukses"
#1759241847
# check
#1759241847
cat /home/komuni60/kci-data/db/admins.json
#1759241900
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759241926
sed -n '1,200p'  ~/kci-api/src/modules/auth/service.ts
#1759242196
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759242196
/home/komuni60/nodevenv/kci-api/20/bin/node - <<'JS'
const fs = require('fs');
const crypto = require('crypto');

const PATH = '/home/komuni60/kci-data/db/admins.json';
const email = 'admin@komunitaschineseindonesia.com';
const full_name = 'Admin';
const role = 'owner';
const password = 'suksesjayasukses';

let data = [];
try { data = JSON.parse(fs.readFileSync(PATH, 'utf8')); } catch (e) {
  if (e.code !== 'ENOENT') throw e;
}

const nextId = arr => arr.reduce((m,a)=>Number.isFinite(a.id)?Math.max(m,a.id):m,0) + 1;

// make scrypt(salt, keylen=64) just like the service
const salt = crypto.randomBytes(16).toString('hex');
const hash = crypto.scryptSync(password, salt, 64).toString('hex');

const record = {
  id: nextId(data),
  email: email.toLowerCase(),
  full_name,
  role,
  password_hash: `${salt}:${hash}`,
  last_login_at: null
};

// drop any old record with same email, then add the correct one
const out = data.filter(a => (a.email||'').toLowerCase() !== record.email);
out.push(record);

fs.mkdirSync('/home/komuni60/kci-data/db', { recursive: true });
fs.writeFileSync(PATH, JSON.stringify(out, null, 2));
console.log('Wrote', PATH);
JS

#1759242203
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759242438
# 1) Put admins.json at DATA_DIR root (no /db)
#1759242438
cp /home/komuni60/kci-data/db/admins.json /home/komuni60/kci-data/admins.json
#1759242438
# 2) Also place a copy in the app’s bundled /data (in case this build reads there)
#1759242438
mkdir -p /home/komuni60/kci-api/data
#1759242438
cp /home/komuni60/kci-data/db/admins.json /home/komuni60/kci-api/data/admins.json
#1759242438
# 3) Nudge Passenger to reload (safe to run)
#1759242438
mkdir -p /home/komuni60/kci-api/tmp
#1759242438
date > /home/komuni60/kci-api/tmp/restart.txt
#1759242449
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759257903
# from the same server
#1759257903
curl -I "http://127.0.0.1:3100/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt"
#1759253627
# 1) Backup the live admins file
#1759253627
cp /home/komuni60/kci-data/admins.json /home/komuni60/kci-data/admins.backup.$(date +%F-%H%M).json
#1759253627
# 2) Remove the default admin@example.com from the live file
#1759253627
/home/komuni60/nodevenv/kci-api/20/bin/node - <<'JS'
const fs = require('fs');
const p  = '/home/komuni60/kci-data/admins.json';
const a  = JSON.parse(fs.readFileSync(p,'utf8'));
const out = a.filter(x => (x.email||'').toLowerCase() !== 'admin@example.com');
fs.writeFileSync(p, JSON.stringify(out, null, 2));
console.log('Kept', out.length, 'admins');
JS

#1759253627
# 3) (Optional) remove the extra copies to avoid confusion
#1759253627
rm -f /home/komuni60/kci-api/data/admins.json
#1759253627
rm -f /home/komuni60/kci-data/db/admins.json
#1759253627
# 4) Nudge Passenger to reload (safe)
#1759253627
mkdir -p /home/komuni60/kci-api/tmp
#1759253627
date > /home/komuni60/kci-api/tmp/restart.txt
#1759253905
# save cookies to reuse the session for the upload
#1759253905
curl -c ~/kci-cookies.txt -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759254020
mkdir -p /home/komuni60/kci-data/uploads
#1759254055
echo "hello from KCI" > /home/komuni60/hello.txt
#1759254055
curl -b ~/kci-cookies.txt -i -X POST   https://api.komunitaschineseindonesia.com/api/media/upload   -F "file=@/home/komuni60/hello.txt;type=text/plain"   -F "title=hello"   -F "alt=test upload"
#1759254171
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759254177
# 1) Enter your node environment so we have the right node binary
#1759254177
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759254178
# 2) Write the same correct record to BOTH likely files
#1759254178
/home/komuni60/nodevenv/kci-api/20/bin/node - <<'JS'
const fs = require('fs');
const crypto = require('crypto');

const targets = [
  '/home/komuni60/kci-data/admins.json',
  '/home/komuni60/kci-api/data/admins.json'
];

const email = 'admin@komunitaschineseindonesia.com';
const full_name = 'Admin';
const role = 'owner';
const password = 'suksesjayasukses';

function readFirst(paths){
  for (const p of paths){
    try {
      if (fs.existsSync(p)) return JSON.parse(fs.readFileSync(p,'utf8'));
    } catch {}
  }
  return [];
}

let data = readFirst(targets);
const nextId = arr => arr.reduce((m,a)=>Number.isFinite(a.id)?Math.max(m,a.id):m,0) + 1;

// scrypt(salt, keylen=64) — matches AuthService.verifyPassword
const salt = crypto.randomBytes(16).toString('hex');
const hash = crypto.scryptSync(password, salt, 64).toString('hex');

const rec = {
  id: nextId(data),
  email: email.toLowerCase(),
  full_name,
  role,
  password_hash: `${salt}:${hash}`,
  last_login_at: null
};

// replace any existing record for this email, then add the correct one
data = data.filter(a => (a.email||'').toLowerCase() !== rec.email);
data.push(rec);

for (const p of targets){
  try {
    fs.mkdirSync(require('path').dirname(p), { recursive: true });
    fs.writeFileSync(p, JSON.stringify(data, null, 2));
    console.log('Wrote', p);
  } catch(e) {
    console.error('Failed to write', p, e.message);
  }
}
JS

#1759254178
# 3) Nudge Passenger to reload
#1759254178
mkdir -p /home/komuni60/kci-api/tmp
#1759254178
date > /home/komuni60/kci-api/tmp/restart.txt
#1759254178
deactivate
#1759254185
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759254500
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759254055707-50bcedec-3cc1-4856-a28f-5d768d10c9f4.txt"
#1759254748
# 1) Make sure the file exists on disk
#1759254748
ls -la /home/komuni60/kci-data/uploads/media | grep 1759254055707
#1759254748
# 2) (If it exists) nudge the API to reload and try again
#1759254748
mkdir -p /home/komuni60/kci-api/tmp
#1759254748
date > /home/komuni60/kci-api/tmp/restart.txt
#1759254748
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759254055707-50bcedec-3cc1-4856-a28f-5d768d10c9f4.txt"
#1759254964
mkdir -p /home/komuni60/kci-data/uploads/media
#1759254973
# reuse your session cookie or re-login first if needed
#1759254973
curl -c ~/kci-cookies.txt -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759254973
# upload again
#1759254973
echo "hello from KCI v2" > /home/komuni60/hello2.txt
#1759254973
curl -b ~/kci-cookies.txt -i -X POST   https://api.komunitaschineseindonesia.com/api/media/upload   -F "file=@/home/komuni60/hello2.txt;type=text/plain"   -F "title=hello2" -F "alt=test upload 2"
#1759255008
# create a public directory for the API app if it doesn't exist
#1759255008
mkdir -p /home/komuni60/kci-api/public
#1759255008
# point public/uploads -> DATA_DIR/uploads
#1759255008
rm -f /home/komuni60/kci-api/public/uploads
#1759255008
ln -s /home/komuni60/kci-data/uploads /home/komuni60/kci-api/public/uploads
#1759255008
# nudge Passenger to reload
#1759255008
mkdir -p /home/komuni60/kci-api/tmp
#1759255008
date > /home/komuni60/kci-api/tmp/restart.txt
#1759255087
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt","metadata":{"originalName":"hello2.txt","mimeType":"text/plain","size":18,"folder":"media","storage":"local","storageKey":"media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt"
#1759255270
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt"
#1759255440
ls -la /home/komuni60/kci-data/uploads/media   | grep 1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt
#1759255644
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759255646
node -v
#1759255663
/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt
#1759255755
ls -l "$DATA/uploads/media/" | grep 1759254973235 || true
#1759255755
# Optional: see contents
#1759255755
cat "$DATA/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt" || true
#1759255961
# Set convenience vars (safe to re-run)
#1759255961
export APP=/home/komuni60/kci-api
#1759255961
export DATA=/home/komuni60/kci-data
#1759255961
export FNAME=1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt
#1759255961
# 1A) Look for the exact file anywhere under your home
#1759255961
find /home/komuni60 -type f -name "$FNAME" 2>/dev/null
#1759255962
# 1B) List any "uploads" folders and see their structure
#1759255962
find /home/komuni60 -type d -name uploads 2>/dev/null | sort
#1759255962
# 1C) Show recent files created in any uploads/* in the last 90 minutes
#1759255962
find /home/komuni60 -path "*/uploads/*" -type f -mmin -90 -ls 2>/dev/null | sort -k7,8
#1759255962
# 1D) Quick peeks in the most likely places
#1759255962
ls -la $APP/uploads 2>/dev/null || true
#1759255962
ls -la $APP/data/uploads 2>/dev/null || true
#1759255962
ls -la $DATA/uploads 2>/dev/null || true
#1759255962
ls -la $APP/public/uploads 2>/dev/null || true
#1759256067
# Create the intended directory (this is where we WANT files)
#1759256067
mkdir -p "$DATA/uploads/media"
#1759256067
chmod 755 "$DATA" "$DATA/uploads" "$DATA/uploads/media"
#1759256082
cd "$APP"
#1759256082
# Add or update DATA_DIR in the app's .htaccess for Passenger
#1759256082
grep -q 'PassengerEnvVar DATA_DIR' .htaccess   && sed -i 's#^PassengerEnvVar DATA_DIR .*#PassengerEnvVar DATA_DIR /home/komuni60/kci-data#' .htaccess   || echo 'PassengerEnvVar DATA_DIR /home/komuni60/kci-data' >> .htaccess
#1759256082
# Sanity print
#1759256082
echo "DATA_DIR should now be /home/komuni60/kci-data"
#1759256132
cd "$APP"
#1759256132
/home/komuni60/nodevenv/kci-api/20/bin/activate 2>/dev/null || true
#1759256132
/home/komuni60/nodevenv/kci-api/20/bin/npm i @fastify/static
#1759256169
const path = require('path');
#1759256169
const fastifyStatic = require('@fastify/static');
#1759256169
const DATA_DIR = process.env.DATA_DIR || '/home/komuni60/kci-data';
#1759256169
fastify.register(fastifyStatic, {
#1759256169
  root: path.join(DATA_DIR, 'uploads'),
#1759256169
  prefix: '/uploads/',  // keep trailing slash
#1759256169
  decorateReply: false,
#1759256169
  index: false,
#1759256169
  cacheControl: true,
#1759256169
});
#1759256308
mkdir -p "$APP/tmp"
#1759256308
date > "$APP/tmp/restart.txt"
#1759256308
# Optional: hit your health endpoint if you have one
#1759256308
curl -s https://api.komunitaschineseindonesia.com/api/healthz || true
#1759256370
# Log in and save cookies (adjust email/password if needed)
#1759256370
curl -c ~/kci-cookies.txt -sS https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'   | jq . >/dev/null 2>&1 || true
#1759256373
# Make a new test file
#1759256373
echo "KCI upload smoke $(date -u +%F\ %T)Z" > ~/smoke.txt
#1759256373
# Upload
#1759256373
curl -b ~/kci-cookies.txt -sS -X POST   https://api.komunitaschineseindonesia.com/api/media/upload   -F "file=@$HOME/smoke.txt;type=text/plain"   -F "title=smoke"   -F "alt=smoke" | tee ~/last-upload.json
#1759256779
export APP=/home/komuni60/kci-api
#1759256779
export DATA=/home/komuni60/kci-data
#1759256779
export LIVE_UPLOADS=/home/komuni60/web/public/uploads
#1759256779
source /home/komuni60/nodevenv/kci-api/20/bin/activate
#1759256779
node -v
#1759256802
cd "$APP"
#1759256802
/home/komuni60/nodevenv/kci-api/20/bin/npm i @fastify/static
#1759256816
cat > "$APP/dist/index.js" <<'JS'
import { buildServer } from './server/server.js';
import { env } from './config/env.js';
import path from 'node:path';
import fastifyStatic from '@fastify/static';

const DATA_DIR = process.env.DATA_DIR || '/home/komuni60/kci-data';
// Point static to where uploads actually are right now:
const UPLOADS_DIR = process.env.UPLOADS_DIR || '/home/komuni60/web/public/uploads';

async function start() {
  const server = await buildServer();

  try {
    // Serve https://api.komunitaschineseindonesia.com/uploads/...
    server.register(fastifyStatic, {
      root: UPLOADS_DIR,                // current real location of files
      prefix: '/uploads/',              // keep trailing slash
      decorateReply: false,
      index: false,
      cacheControl: true,
      // fallthrough: true   // (optional) if you want 404 to go to routes
    });

    const port = Number(process.env.PORT || env.server.port);
    const host = process.env.HOST || env.server.host || '127.0.0.1';
    await server.listen({ port, host });
    server.log.info(`API server listening on http://${host}:${port}`);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

start();
JS

#1759256838
cd "$APP"
#1759256838
grep -q 'PassengerEnvVar UPLOADS_DIR' .htaccess   && sed -i 's#^PassengerEnvVar UPLOADS_DIR .*#PassengerEnvVar UPLOADS_DIR '"$LIVE_UPLOADS"'#' .htaccess   || echo 'PassengerEnvVar UPLOADS_DIR '"$LIVE_UPLOADS" >> .htaccess
#1759256838
# Keep DATA_DIR too (you already set it earlier; set again just to be sure)
#1759256838
grep -q 'PassengerEnvVar DATA_DIR' .htaccess   && sed -i 's#^PassengerEnvVar DATA_DIR .*#PassengerEnvVar DATA_DIR '"$DATA"'#' .htaccess   || echo 'PassengerEnvVar DATA_DIR '"$DATA" >> .htaccess
#1759256844
mkdir -p "$APP/tmp"
#1759256844
date > "$APP/tmp/restart.txt"
#1759256855
# If you have a JSON health:
#1759256855
curl -sS https://api.komunitaschineseindonesia.com/api/healthz || true
#1759256858
# Or just hit /api root:
#1759256858
curl -i https://api.komunitaschineseindonesia.com/api | head -n 20
#1759256903
grep -R "<Error ID here>" -n ~/logs 2>/dev/null | tail -n 20
#1759256903
tail -n 200 ~/logs/error_log 2>/dev/null | sed -n '$p'
#1759256974
tail -n 200 ~logs/passenger.log
#1759257363
APP=/home/komuni60/kci-api
#1759257363
# 1) List all logs so we know the exact filenames Passenger/Apache writes to
#1759257363
ls -lah ~/logs
#1759257363
# 2) Tail the common Passenger logs
#1759257363
tail -n 200 ~/logs/passenger.log 2>/dev/null
#1759257363
# 3) Tail Apache domain logs (api.* names vary per host)
#1759257363
tail -n 200 ~/logs/*api*error* 2>/dev/null
#1759257363
tail -n 200 ~/logs/*api*log 2>/dev/null
#1759257363
tail -n 200 ~/logs/error_log 2>/dev/null
#1759257363
# 4) Show .htaccess (Passenger settings) to confirm startup file and env are what we think
#1759257363
sed -n '1,200p' "$APP/.htaccess"
#1759257404
APP=/home/komuni60/kci-api
#1759257404
cd "$APP"
#1759257404
# Make sure node_modules exist and the plugin is really there
#1759257404
ls -ld node_modules  ;  ls -ld node_modules/@fastify/static  || echo "static plugin missing"
#1759257404
# Show package.json 'type' (ESM vs CJS matters)
#1759257404
jq -r '.type // "NO_TYPE_FIELD"' package.json 2>/dev/null || cat package.json
#1759257404
# Run with safe env and a different port so it won't conflict with Passenger
#1759257404
export NODE_ENV=production
#1759257404
export HOST=127.0.0.1
#1759257404
export PORT=3100
#1759257404
export DATA_DIR=/home/komuni60/kci-data
#1759257404
export UPLOADS_DIR=/home/komuni60/web/public/uploads
#1759257404
node --trace-uncaught --trace-warnings dist/index.js
#1759257432
# .htaccess should include something like (examples):
#1759257432
PassengerAppRoot /home/komuni60/kci-api
#1759257432
PassengerStartupFile dist/index.js
#1759257432
PassengerAppType node
#1759257432
PassengerNodejs /home/komuni60/nodevenv/kci-api/20/bin/node
#1759257711
# still in: /home/komuni60/kci-api  (APP)
#1759257711
node -p "require('fastify/package.json').version"
#1759257712
node -p "require('@fastify/static/package.json').version"
#1759257733
# remove current (v8)
#1759257733
npm rm @fastify/static
#1759257755
# install the v7 line (compatible with Fastify 4.x)
#1759257755
npm i @fastify/static@^7
#1759257774
node -p "require('@fastify/static/package.json').version"
#1759257774
# -> should print 7.x.x
#1759257792
export NODE_ENV=production
#1759257792
export HOST=127.0.0.1
#1759257792
export PORT=3100
#1759257792
export DATA_DIR=/home/komuni60/kci-data
#1759257792
export UPLOADS_DIR=/home/komuni60/web/public/uploads
#1759257792
node --trace-uncaught --trace-warnings dist/index.js
#1759257926
# make sure the env vars are in .htaccess (you already added these)
#1759257926
sed -n '1,200p' .htaccess
#1759257926
# restart Passenger
#1759257926
mkdir -p ./tmp
#1759257926
date > ./tmp/restart.txt
#1759257926
# test public
#1759257926
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt"
#1759258571
find /home/komuni60/web/public/uploads -type d -exec chmod 755 {} \;
#1759258571
find /home/komuni60/web/public/uploads -type f -exec chmod 644 {} \;
#1759258974
cd /home/komuni60/kci-api
#1759258974
# Insert imports and the static registration block
#1759258974
awk 'BEGIN{added=0}
{
  print
}
NR==3 && !done_import {
  # (we’ll add imports right after the existing imports)
}
' src/server/server.ts > /dev/null 2>&1
#1759258974
# Use a safe, idempotent in-place edit with perl:
#1759258974
perl -0777 -pe "
  s|import sensible from '@fastify/sensible';|import sensible from '@fastify/sensible';\\nimport fastifyStatic from '@fastify/static';\\nimport path from 'node:path';|s;
  s|server\\.get\\('/healthz'|  // Serve uploaded assets\\n  {\\n    const defaultUploads = path.resolve(process.cwd(), '../web/public/uploads');\\n    const uploadsRoot = process.env.UPLOADS_DIR || defaultUploads;\\n    await server.register(fastifyStatic, {\\n      root: uploadsRoot,\\n      prefix: '/uploads/',\\n      decorateReply: false,\\n      index: false,\\n      cacheControl: true,\\n    });\\n  }\\n\\nserver.get\\('/healthz'|s;
" -i src/server/server.ts
#1759259122
perl -0777 -pe "
  s|const LOCAL_UPLOAD_ROOT = path\\.resolve\\(appsDir, 'web/public/uploads'\\);|const LOCAL_UPLOAD_ROOT = (process.env.UPLOADS_DIR && process.env.UPLOADS_DIR.trim().length > 0)\\n  ? process.env.UPLOADS_DIR\\n  : path.resolve(appsDir, 'web/public/uploads');|s;
" -i src/modules/media/routes.ts
#1759259218
# Add dep (keeps CloudLinux from pulling v8 later)
#1759259218
npm pkg set dependencies.@fastify/static="^6"
#1759259220
# Install into the CloudLinux venv (symlinked node_modules)
#1759259220
# (use the v20 npm if plain `npm` isn’t on PATH)
#1759259220
npm i
#1759259260
npm run build
#1759259261
mkdir -p ./tmp && date > ./tmp/restart.txt
#1759259268
# HEAD on an existing file you already uploaded
#1759259268
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759254973235-2b8ffa7b-b341-4799-83df-752188f1c604.txt"
#1759259271
# Upload another tiny file and verify it serves
#1759259271
echo "smoke $(date -u +%F\ %T)Z" > ~/smoke.txt
#1759259271
curl -c ~/kci-cookies.txt -sS https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}' >/dev/null
#1759259271
curl -b ~/kci-cookies.txt -sS -X POST   https://api.komunitaschineseindonesia.com/api/media/upload   -F "file=@$HOME/smoke.txt;type=text/plain" -F "title=smoke" -F "alt=smoke" | tee ~/last-upload.json
#1759259271
URL=$(sed -n 's/.*"url":"\([^"]*\)".*/\1/p' ~/last-upload.json)
#1759259271
curl -I "https://api.komunitaschineseindonesia.com$URL"
#1759259348
rsync -av /home/komuni60/web/public/uploads/ /home/komuni60/kci-data/uploads/
#1759259348
sed -i 's#^PassengerEnvVar UPLOADS_DIR .*#PassengerEnvVar UPLOADS_DIR /home/komuni60/kci-data/uploads#' /home/komuni60/kci-api/.htaccess
#1759259348
mkdir -p /home/komuni60/kci-api/tmp && date > /home/komuni60/kci-api/tmp/restart.txt
#1759259738
# only do this if /home/komuni60/kci-data/uploads is empty or disposable
#1759259738
rm -rf /home/komuni60/kci-data/uploads
#1759259738
ln -s /home/komuni60/web/public/uploads /home/komuni60/kci-data/uploads
#1759259738
# Passenger already points to kci-data/uploads; just restart
#1759259738
mkdir -p /home/komuni60/kci-api/tmp && date > /home/komuni60/kci-api/tmp/restart.txt
#1759259738
# test a fresh upload
#1759259738
echo "symlink-check $(date -u +%F\ %T)Z" > ~/smoke3.txt
#1759259738
curl -b ~/kci-cookies.txt -sS -X POST   https://api.komunitaschineseindonesia.com/api/media/upload   -F "file=@$HOME/smoke3.txt;type=text/plain" -F "title=smoke3" -F "alt=smoke3" | tee ~/last-upload.json
#1759259741
URL=$(sed -n 's/.*"url":"\([^"]*\)".*/\1/p' ~/last-upload.json)
#1759259741
curl -I "https://api.komunitaschineseindonesia.com$URL"
#1759390623
curl -i https://api.komunitaschineseindonesia.com/healthz
#1759390626
curl -i https://api.komunitaschineseindonesia.com/api
#1759390667
# Verify symlinks
#1759390667
ls -l /home/komuni60/kci-api/public/uploads
#1759390667
ls -l /home/komuni60/public_html/uploads
#1759390667
# HEAD an uploaded file (replace with a real filename)
#1759390667
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/<filename>"
#1759390877
curl -i https://api.komunitaschineseindonesia.com/api/auth/login   -H 'Content-Type: application/json'   --data '{"email":"admin@komunitaschineseindonesia.com","password":"suksesjayasukses"}'
#1759390972
# apps/web/.env.local
#1759390972
NEXT_PUBLIC_API_BASE=https://api.komunitaschineseindonesia.com/api
#1759392321
# Pick a small file on the server to test
#1759392321
TEST="/etc/hosts"
#1759392321
curl -sS -F "file=@${TEST}" -F "folder=media"   https://api.komunitaschineseindonesia.com/api/media/upload | jq
#1759392321
# Expect JSON like: { publicUrl: "/uploads/media/<name>", storageKey: "media/<name>" }
#1759392321
# Then:
#1759392321
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/<name>"
#1759392366
# Create or publish an event in CMS
#1759392366
curl -sS -X POST -H 'Content-Type: application/json'   -d '{"title":"Smoke Test","status":"published","starts_at":"2025-10-02T12:00:00+07:00"}'   https://api.komunitaschineseindonesia.com/api/events | jq
#1759392366
# Visit the public events page under https://komunitaschineseindonesia.com/cms/ (your events page)
#1759392366
# It should reflect immediately since the frontend fetches the API at runtime.
#1759392408
# Should reflect /home/komuni60/kci-api/data/*.json
#1759392408
grep -H . /home/komuni60/kci-api/data/events.json
#1759392669
# See that it's a symlink and where it points
#1759392669
ls -ld /home/komuni60/kci-api/public/uploads
#1759392670
readlink -f /home/komuni60/kci-api/public/uploads
#1759392670
# Remove ONLY the symlink, not the target
#1759392670
rm -f /home/komuni60/kci-api/public/uploads
#1759392670
# Sanity check: files still there
#1759392670
ls -l /home/komuni60/web/public/uploads
#1759392699
curl -I "https://api.komunitaschineseindonesia.com/uploads/media/1759392321897-fd7da438-13a8-4992-a907-8f9ea4126f58"
#1759392743
curl -sS -X POST -H 'Content-Type: application/json'   -d '{
    "title": "Smoke Test",
    "slug": "smoke-test",
    "summary": "Short one-liner for the card.",
    "description": "Longer description for the event page.",
    "location": "Stasiun Manggarai",
    "starts_at": "2025-10-02T12:00:00+07:00",
    "ends_at":   "2025-10-02T15:00:00+07:00",
    "hero_image_url": "https://api.komunitaschineseindonesia.com/uploads/media/1759392321897-fd7da438-13a8-4992-a907-8f9ea4126f58",
    "is_published": true
  }'   https://api.komunitaschineseindonesia.com/api/events | jq
#1759392754
curl -sS https://api.komunitaschineseindonesia.com/api/events | jq
#1759392770
grep -n 'NEXT_PUBLIC_API_BASE' ~/kci-repo/apps/web/.env.local
#1759392770
# should be exactly:
#1759392770
# NEXT_PUBLIC_API_BASE=https://api.komunitaschineseindonesia.com/api
#1759573582
cd /home/komuni60/kci-repo
#1759573596
cd /home/komuni60/kci-repo
#1759573865
# --- config (edit these) ---
#1759573865
REPO_DIR="/home/homuni60/kci-repo"                    # your repo path from Git Version Control
#1759573865
APP_URL="https://komunitaschineseindonesia.com/cms"   # page to probe after restart
#1759573865
HEALTH_URL="https://api.komunitaschineseindonesia.com/healthz"  # if you have one
#1759573865
# --- preflight (read-only) ---
#1759573865
cd "$REPO_DIR" || exit 1
#1759573889
cls
#1759573891
clr
#1759573896
# --- config (edit these) ---
#1759573896
REPO_DIR="home/homuni60/kci-repo"                    # your repo path from Git Version Control
#1759573896
APP_URL="https://komunitaschineseindonesia.com/cms"   # page to probe after restart
#1759573896
HEALTH_URL="https://api.komunitaschineseindonesia.com/healthz"  # if you have one
#1759573896
# --- preflight (read-only) ---
#1759573896
cd "$REPO_DIR" || exit 1
#1759573970
cd ..
#1759573975
cd .
#1759573978
cd ..
#1759574006
# --- config (edit these) ---
#1759574006
REPO_DIR="/home/homuni60/kci-repo"                    # your repo path from Git Version Control
#1759574006
APP_URL="https://komunitaschineseindonesia.com/cms"   # page to probe after restart
#1759574006
HEALTH_URL="https://api.komunitaschineseindonesia.com/healthz"  # if you have one
#1759574006
# --- preflight (read-only) ---
#1759574006
cd "$REPO_DIR" || exit 1
#1759577130
# --- PATHS ---
#1759577130
REPO_ROOT="/home/komuni60/kci-repo"
#1759577130
WEB_DIR="$REPO_ROOT/apps/web"
#1759577130
API_ROOT="/home/komuni60/kci-api"
#1759577130
DOCROOT="/home/komuni60/public_html/cms"
#1759577130
# 1) activate CloudLinux nodevenv for your API app (temporarily disable nounset)
#1759577130
set +u
#1759577130
for v in 22 20 18 16; do   ACT="$HOME/nodevenv/kci-api/$v/bin/activate";   if [ -f "$ACT" ]; then . "$ACT"; found=1; break; fi; done
#1759577130
set -u
#1759577130
# sanity
#1759577130
node -v && npm -v
#1759577131
# 2) build web (static export)
#1759577131
cd "$REPO_ROOT"
#1759577131
npm ci || npm install
#1759577147
npm --workspace apps/web run build || (cd "$WEB_DIR" && npx next build && npx next export -o out)
#1759577473
# --- build ONLY the web workspace ---
#1759577473
cd /home/komuni60/kci-repo/apps/web
#1759577473
# clean any partial installs
#1759577473
rm -rf node_modules .next out
#1759577473
# install deps for the web workspace (not the whole monorepo)
#1759577473
npm install
#1759577476
# build (this uses your project's Next.js version + native SWC binary)
#1759577476
npm run build || npx next build
#1759577483
# export static site (run whichever exists; either script or direct)
#1759577483
npm run export || npx next export -o out
#1759577488
# sanity: "out" must exist now
#1759577488
ls -lah out | head
#1759577539
# publish static files live
#1759577539
rsync -avh --delete /home/komuni60/kci-repo/apps/web/out/ /home/komuni60/public_html/cms/
#1759577539
# restart API (safe; touches only the API process)
#1759577539
cd /home/komuni60/kci-api && mkdir -p tmp && touch tmp/restart.txt
#1759577539
# verify (cache-buster)
#1759577539
curl -I "https://komunitaschineseindonesia.com/cms/?v=$(date +%s)"
#1759578666
# API health (should be OK)
#1759578666
curl -i https://api.komunitaschineseindonesia.com/healthz
#1759578666
# Admins list (you used this before)
#1759578666
curl -s https://api.komunitaschineseindonesia.com/api/auth
#1759578743
################################################################################
#1759578743
# 0) Prereqs
#1759578743
################################################################################
#1759578743
set -euo pipefail
#1759578743
TS=$(date +%Y%m%d-%H%M%S)
#1759578743
################################################################################
#1759578743
# 1) Pull latest repo (if you haven’t already via cPanel Git)
#1759578743
################################################################################
#1759578743
cd ~/kci-repo
#1759578743
git status
#1759578743
git pull --ff-only
#1759578744
################################################################################
#1759578744
# 2) DEPLOY API
#1759578744
#    Sync source from repo -> live API folder (excluding data & uploads),
#1759578744
#    install deps, build, and restart Passenger.
#1759578744
################################################################################
#1759578744
# Backup current dist just in case
#1759578744
mkdir -p ~/backups
#1759578744
tar -C ~/kci-api -czf ~/backups/kci-api-dist-$TS.tgz dist || true
#1759578744
# Sync source (do NOT overwrite data/uploads)
#1759578744
rsync -av --delete   --exclude 'data/'   --exclude 'uploads/'   ~/kci-repo/apps/api/ ~/kci-api/
#1759578744
# Use the API’s Node v20 environment
#1759578744
source ~/nodevenv/kci-api/20/bin/activate
#1759578744
# Clean install + build TypeScript -> dist
#1759578744
cd ~/kci-api
#1759578744
npm ci
#1759578989
# 1) Use the API Node v20 env
#1759578989
source ~/nodevenv/kci-api/20/bin/activate
#1759578989
cd ~/kci-api
#1759578989
# 2) Remove the odd node_modules symlink that rsync copied
#1759578989
rm -rf node_modules
#1759578989
# 3) If your repo has a lockfile, use it; otherwise just install
#1759578989
if [ -f ~/kci-repo/apps/api/package-lock.json ]; then   cp ~/kci-repo/apps/api/package-lock.json .;   npm ci; else   npm install; fi
#1759578992
# 4) Build and restart Passenger
#1759578992
npm run build
#1759578993
mkdir -p ~/public_html/tmp
#1759578993
touch ~/public_html/tmp/restart.txt
#1759578993
# 5) Sanity check
#1759578993
curl -sS https://api.komunitaschineseindonesia.com/healthz
#1759579046
# 1) Use the repo Node v20 env
#1759579046
source ~/nodevenv/kci-repo/20/bin/activate
#1759579046
cd ~/kci-repo/apps/web
#1759579046
# 2) Ensure API base is correct for static export
#1759579046
printf "NEXT_PUBLIC_API_BASE=https://api.komunitaschineseindonesia.com/api\n" > .env.local
#1759579046
# 3) Install deps (use lockfile if you have one; otherwise install)
#1759579046
[ -f package-lock.json ] && npm ci || npm install
#1759579048
# 4) Build static CMS
#1759579048
npm run build:cms   # (next build && next export -o out)
#1759579049
# 5) Publish to live /cms
#1759579049
mkdir -p ~/backups
#1759579049
if [ -d ~/public_html/cms ]; then   tar -C ~/public_html -czf ~/backups/cms-$(date +%Y%m%d-%H%M%S).tgz cms; fi
#1759579049
mkdir -p ~/public_html/cms
#1759579049
rsync -av --delete ~/kci-repo/apps/web/out/ ~/public_html/cms/
#1759579049
# 6) Make sure Passenger is off under /cms (static site)
#1759579049
printf "PassengerEnabled off\nOptions -MultiViews\nDirectoryIndex index.html\n" > ~/public_html/cms/.htaccess
#1759579049
# 7) Smoke tests
#1759579049
curl -I https://komunitaschineseindonesia.com/cms/
#1759579049
curl -I https://komunitaschineseindonesia.com/cms/admin
#1759579246
# 0) Use the repo Node v20 env
#1759579246
source ~/nodevenv/kci-repo/20/bin/activate
#1759579246
set -euo pipefail
#1759579246
# 1) Ensure the API base for the static export
#1759579246
cd ~/kci-repo/apps/web
#1759579246
printf "NEXT_PUBLIC_API_BASE=https://api.komunitaschineseindonesia.com/api\n" > .env.local
#1759579246
# 2) Try a workspace-root install if this is a monorepo with workspaces
#1759579246
cd ~/kci-repo
#1759579246
if node -e "try{process.exit(cd ~/kci-reporequire('./package.json').workspaces?0:1)}catch(e){process.exit(1)}"; then   if [ -f package-lock.json ]; then npm ci; else npm install; fi;    npm -w web run build:cms || (     cd apps/web     rm -rf node_modules;     npm install next react react-dom;     npm install -D typescript @types/react @types/node;     npm run build:cms;   ); else   cd apps/web;   rm -rf node_modules;   [ -f package-lock.json ] && npm ci || npm install;    if ! [ -x node_modules/.bin/next ]; then     npm install next react react-dom;     npm install -D typescript @types/react @types/node;   fi;    npm pkg set scripts.build:cms="next build && next export -o out";   npm run build:cms; fi
#1759584310
# 1) Inspect what you currently have
#1759584310
ls -la ~/public_html/cms | head -n 50
#1759584310
# 2) If you see a nested "out" or "cms" folder, flatten it safely:
#1759584310
set -e
#1759584310
cd ~/public_html/cms
#1759584310
# Backup current live CMS
#1759584310
mkdir -p ~/backups
#1759584310
tar -czf ~/backups/cms-before-fix-$(date +%Y%m%d-%H%M%S).tgz . || true
#1759584311
# If extracted as cms/out/*  -> move up
#1759584311
if [ -d out ]; then   rsync -a out/ ./;   rm -rf out; fi
#1759584311
# If your build used basePath:'/cms' and created a nested cms/* -> move up
#1759584311
if [ -d cms ] && [ -f cms/index.html ]; then   rsync -a cms/ ./;   rm -rf cms; fi
#1759584311
# Ensure static serving and default index
#1759584311
printf "PassengerEnabled off\nOptions -MultiViews\nDirectoryIndex index.html\n" > .htaccess
#1759584311
# 3) Quick checks
#1759584311
test -f index.html && echo "OK: index.html present" || echo "MISSING index.html"
#1759584313
ls -la | head -n 50
#1759584361
curl -i https://api.komunitaschineseindonesia.com/api/posts
#1759588076
# on the server
#1759588076
cd /home/komuni60/kci-repo
#1759588076
git fetch origin
#1759588077
# deploy exactly what's on main without accidental merges
#1759588077
git checkout main
#1759588077
git reset --hard origin/main
#1759588127
# API build (adjust if your API path differs)
#1759588127
cd /home/komuni60/kci-repo/apps/api
#1759588127
# install only if package.json/package-lock changed
#1759588127
npm ci --omit=dev || npm ci
#1759588145
cd /home/komuni60/kci-repo/apps/api
#1759588145
mkdir -p tmp && touch tmp/restart.txt
#1759589019
cd /home/komuni60/kci-repo/apps/api
#1759589019
mkdir -p tmp && touch tmp/restart.txt
#1759589591
# on the server (or wherever you build the static CMS)
#1759589591
cd /home/komuni60/kci-repo/apps/web
#1759589591
# set production API base (one-time file)
#1759589591
printf "NEXT_PUBLIC_API_BASE_URL=https://api.komunitaschineseindonesia.com\n" > .env.production
#1759589591
# (your next.config.js should already have basePath:'/cms' and images.unoptimized:true)
#1759589591
npm ci || npm install
#1759589591
npm run build
#1759589591
npm run export   # outputs ./out
#1759589591
# zip the CONTENTS of out (avoid nesting /out)
#1759589591
cd out
#1759589591
zip -r ../cms-export.zip .
#1759589591
mv ../cms-export.zip /home/komuni60/tmp/
#1759589591
# deploy
#1759589591
cd /home/komuni60/public_html/cms
#1759589591
find . -mindepth 1 -maxdepth 1 -exec rm -rf {} +
#1759589591
unzip /home/komuni60/tmp/cms-export.zip -d /home/komuni60/public_html/cms
#1759589653
grep -R "127.0.0.1:3001" -n /home/komuni60/public_html/cms/_next || echo "OK: no localhost hardcoded"
#1759590652
# confirm no localhost baked into the bundle
#1759590652
grep -R "127.0.0.1:3001\|http://localhost:3001" -n /home/komuni60/public_html/cms/_next || echo "OK: API domain baked in"
#1759590652
# API health
#1759590652
curl -s https://api.komunitaschineseindonesia.com/healthz
#1759590652
# CORS preflight from your site origin (should show Access-Control-Allow-Origin with your domain)
#1759590652
curl -i -X OPTIONS https://api.komunitaschineseindonesia.com/gallery   -H 'Origin: https://komunitaschineseindonesia.com'   -H 'Access-Control-Request-Method: GET'
#1759591260
# no localhost in the deployed JS
#1759591260
grep -R "127.0.0.1:3001\|http://localhost:3001" -n /home/komuni60/public_html/cms/_next || echo "OK"
#1759591260
# pages should return 200
#1759591260
curl -I https://komunitaschineseindonesia.com/cms/
#1759591260
curl -I https://komunitaschineseindonesia.com/cms/admin/media/
#1759591260
# your API should be the one receiving calls
#1759591260
curl -s https://api.komunitaschineseindonesia.com/healthz
