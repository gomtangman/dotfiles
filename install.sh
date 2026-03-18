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

echo ""
echo "✅ 완료! 새 터미널을 열어주세요."
