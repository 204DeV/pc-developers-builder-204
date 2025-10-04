\#!/bin/bash
set -e

echo "🚀 Starting setup for P & C Developers Builder 204..."

# === CONFIG ===
GITHUB_USER="204DeV"
REPO_NAME="pc-developers-builder-204"
GITHUB_PAT="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"   # <-- replace if you regenerate token
USER_EMAIL="petruzimbru@icloud.com"

# === Git global config ===
git config --global user.name "$GITHUB_USER"
git config --global user.email "$USER_EMAIL"
git config --global credential.helper store

# === Save credentials for automatic pushes ===
echo "https://$GITHUB_USER:$GITHUB_PAT@github.com" > ~/.git-credentials

# === Create GitHub repo if not exists ===
echo "📡 Creating GitHub repo $REPO_NAME..."
# === Create GitHub repo if it does not exist ===
if curl -s -H "Authorization: token $GITHUB_PAT" https://api.github.com/repos/$GITHUB_USER/$REPO_NAME | grep -q '"id":'; then
  echo "✅ Repo $REPO_NAME already exists on GitHub."
else
  echo "📡 Creating new repo $REPO_NAME..."
  curl -s -H "Authorization: token $GITHUB_PAT" https://api.github.com/user/repos -d "{\"name\":\"$REPO_NAME\"}" | jq .
fi

# === Project structure ===
mkdir -p ~/$REPO_NAME/{pc-extension-pack-204,workspace-204/{frontend-204,backend-204,database-204,ai-204}}
cd ~/$REPO_NAME/pc-extension-pack-204

# === Extension Pack ===
cat > package.json << 'EOF'
{
  "name": "pc-developers-builder-204",
  "displayName": "P & C Developers Builder 204 Pack",
  "description": "All-in-one AI-assisted full-stack environment for Chromebook ARM64 — PHP, MySQL, Supabase, Stripe, and Lovable.dev-style coding.",
  "version": "1.0.0",
  "publisher": "204DeV",
  "repository": {
    "type": "git",
    "url": "https://github.com/204DeV/pc-developers-builder-204.git"
  },
  "license": "MIT",
  "engines": { "vscode": "^1.50.0" },
  "categories": ["Extension Packs"],
  "extensionPack": [
    "ecmel.vscode-html-css",
    "xabikos.JavaScriptSnippets",
    "bmewburn.vscode-intelephense-client",
    "brapifra.phpserver",
    "ritwickdey.liveserver",
    "esbenp.prettier-vscode",
    "formulahendry.auto-rename-tag",
    "christian-kohler.path-intellisense",
    "cweijan.vscode-mysql-client2",
    "mtxr.sqltools",
    "mtxr.sqltools-driver-mysql",
    "supabase.supabase-vscode",
    "eamodio.gitlens",
    "GitHub.copilot",
    "ms-azuretools.vscode-docker",
    "ms-vscode-remote.remote-ssh",
    "DanielSanMedium.dscodegpt",
    "Continue.continue",
    "humao.rest-client",
    "rangav.vscode-thunder-client",
    "bradlc.vscode-tailwindcss",
    "pranaygp.vscode-css-peek",
    "idleberg.icon-fonts",
    "stripe.vscode-stripe",
    "xdebug.php-debug",
    "shd101wyy.markdown-preview-enhanced"
  ]
}
EOF

# === License ===
cat > LICENSE << 'EOF'
MIT License
Copyright (c) 2025 204DeV
EOF

# Build extension pack
vsce package
code --install-extension pc-developers-builder-204-1.0.0.vsix

# === Workspace ===
cd ~/$REPO_NAME/workspace-204

# Frontend
cat > frontend-204/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>P & C Developers Builder 204</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Welcome to P & C Developers Builder 204 🚀</h1>
<p>Your AI-powered full-stack environment is ready.</p>
<script src="app.js"></script>
</body>
</html>
EOF

cat > frontend-204/style.css << 'EOF'
body { background:#0a0a0a; color:#00ffff; text-align:center; padding:60px; font-family: 'Poppins', sans-serif; }
h1 { color:#b5179e; text-shadow:0 0 15px #00ffff; font-size:2.2rem; }
EOF

cat > frontend-204/app.js << 'EOF'
console.log("Frontend ready!");
EOF

# Backend
cat > backend-204/server.php << 'EOF'
<?php
header('Content-Type: application/json');
echo json_encode([
  "status" => "Backend active",
  "project" => "P & C Developers Builder 204",
  "time" => date("Y-m-d H:i:s")
]);
?>
EOF

# Database
cat > database-204/schema.sql << 'EOF'
CREATE DATABASE pc_builder_204;
USE pc_builder_204;
CREATE TABLE developers_204 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(150),
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

# AI Prompts
cat > ai-204/prompts.md << 'EOF'
# 🤖 AI Prompts
- "Build a PHP login with MySQL"
- "Create Supabase auth"
- "Stripe checkout 10 EUR"
EOF

# === Initialize Git & Push ===
cd ~/$REPO_NAME
git init
git add .
git commit -m "Initial commit: P & C Developers Builder 204"
git branch -M main
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git
git push -u origin main

# === Auto branch alias ===
git config --global alias.newproject '!f() { git checkout -b "$1" && git push -u origin "$1"; }; f'

# === Auto ZIP backup ===
cd ~
zip -r ${REPO_NAME}.zip ${REPO_NAME} setup-pc-builder-204.sh

echo "✅ Setup complete!"
echo "➡️ Open VS Code with: code ~/$REPO_NAME/workspace-204"
echo "📦 Backup saved as: ~/${REPO_NAME}.zip"
