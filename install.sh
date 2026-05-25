#!/bin/bash

# ============================================================
#  Dotfiles Install Script
#  새 맥에서 실행: bash install.sh
# ============================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Dotfiles 설치 시작..."

# ------------------------------------------------------------
# 심볼릭 링크 생성 함수
# 원본을 복사하는 대신 링크를 걸어두면
# 리포에서 pull 받을 때 자동으로 반영됨
# ------------------------------------------------------------
link() {
  local src="$1"
  local dest="$2"

  if [ -f "$dest" ] && [ ! -L "$dest" ]; then
    echo "  백업: $dest → $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -sf "$src" "$dest"
  echo "  ✅ 링크 생성: $dest → $src"
}

# ------------------------------------------------------------
# Vim
# ------------------------------------------------------------
echo ""
echo "📦 Vim 설정 중..."
mkdir -p ~/.vim/undodir
link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# ------------------------------------------------------------
# Git (있는 경우)
# ------------------------------------------------------------
if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
  echo ""
  echo "📦 Git 설정 중..."
  link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
fi

# ------------------------------------------------------------
# Zsh (있는 경우)
# ------------------------------------------------------------
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
  echo ""
  echo "📦 Zsh 설정 중..."
  link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

# ------------------------------------------------------------
# Ghostty
# ------------------------------------------------------------
if [ -f "$DOTFILES_DIR/ghostty/config" ]; then
  echo ""
  echo "📦 Ghostty 설정 중..."
  mkdir -p "$HOME/.config/ghostty"
  link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
fi

# ------------------------------------------------------------
# Homebrew 패키지 설치 (선택)
# ------------------------------------------------------------
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo ""
  echo "🍺 Homebrew 패키지 설치 중..."
  if ! command -v brew &>/dev/null; then
    echo "  Homebrew 설치 중..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# ------------------------------------------------------------
# Espanso 설정
# ------------------------------------------------------------
echo ""
echo "📦 Espanso 설정 중..."
ESPANSO_CONFIG_DIR="$HOME/Library/Application Support/espanso"
ESPANSO_SRC="$DOTFILES_DIR/espanso"

if [ -d "$ESPANSO_SRC" ]; then
  mkdir -p "$ESPANSO_CONFIG_DIR"
  link "$ESPANSO_SRC/config/default.yml" "$ESPANSO_CONFIG_DIR/config/default.yml"
  link "$ESPANSO_SRC/match/base.yml"     "$ESPANSO_CONFIG_DIR/match/base.yml"
  echo "  ✅ Espanso 설정 완료 (espanso restart 로 적용)"
else
  echo "  ℹ️  espanso/ 폴더 없음, 건너뜀"
fi

# ------------------------------------------------------------
# Claude Code 설치
# ------------------------------------------------------------
echo ""
echo "🤖 Claude Code 설치 중 (Native Installer)..."
if command -v claude &>/dev/null; then
  echo "  ℹ️  Claude Code 이미 설치되어 있음: $(claude --version)"
else
  /bin/bash -c "$(curl -fsSL https://claude.ai/install.sh)"
  echo "  ✅ Claude Code 설치 완료"
  echo "  ℹ️  PATH 반영을 위해 아래 명령어를 실행하세요:"
  echo "      source ~/.zshrc  (또는 새 터미널 열기)"
  echo "  👉 이후 'claude' 명령어 실행 후 브라우저에서 로그인하세요."
  echo ""
  echo "  ⚠️  'claude: command not found' 가 뜨면 아래를 시도하세요:"
  echo "  1) source ~/.zshrc 후 재시도"
  echo "  2) 그래도 안 되면 수동으로 PATH 추가:"
  echo "      echo 'export PATH=\"\$HOME/.claude/bin:\$PATH\"' >> ~/.zshrc"
  echo "      source ~/.zshrc"
  echo "  3) 설치 위치 확인: ls ~/.claude/bin/"
fi

# ------------------------------------------------------------
# Claude Code Plugins (수동 설치 안내)
# 슬래시 커맨드는 셸이 아니라 Claude Code 안에서 실행됨
# ------------------------------------------------------------
echo ""
echo "🤖 Claude Code 플러그인 설치 안내"
echo "  Claude Code를 실행한 뒤 아래 명령어를 입력하세요:"
echo ""
echo "    /plugin marketplace add addyosmani/agent-skills"
echo "    /plugin install agent-skills@addy-agent-skills"
echo ""
echo "    /plugin marketplace add forrestchang/andrej-karpathy-skills"
echo "    /plugin install andrej-karpathy-skills@karpathy-skills"
echo ""
echo "  설치 후 /reload-plugins 실행"
echo ""
echo "  터미널/스테이터스라인 설정:"
echo "    /terminal-setup       # Shift+Enter 등 터미널 키바인딩 설정"
echo "    /statusline           # 스테이터스라인에 현재 git 브랜치 표시"

echo ""
echo "✅ 완료! 새 터미널을 열어주세요."
