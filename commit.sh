#!/bin/bash

# Színek a kimenethez
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Függvény a git állapot ellenőrzésére és commit-ra
commit_project() {
    local project_path=$1
    local project_name=$2

    echo -e "${BLUE}=== Checking ${project_name} ===${NC}"

    if [ ! -d "$project_path/.git" ]; then
        echo -e "${YELLOW}⚠ Not a git repository: ${project_path}${NC}"
        return
    fi

    cd "$project_path" || return

    # Ellenőrizzük van-e változás
    if [ -z "$(git status --porcelain)" ]; then
        echo -e "${GREEN}✓ No changes in ${project_name}${NC}"
        return
    fi

    # Mutassuk a változásokat
    echo -e "${YELLOW}Changes in ${project_name}:${NC}"
    git status --short

    # Kérjünk commit üzenetet
    echo -e "${BLUE}Enter commit message for ${project_name} (or press Enter to skip):${NC}"
    read -r commit_message

    if [ -z "$commit_message" ]; then
        echo -e "${YELLOW}⊘ Skipped ${project_name}${NC}"
        return
    fi

    # Add és commit
    git add .
    git commit -m "$commit_message"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Committed ${project_name}${NC}"

        # Kérdezzük meg push-oljon-e
        echo -e "${BLUE}Push changes? (y/N):${NC}"
        read -r push_answer

        if [[ "$push_answer" =~ ^[Yy]$ ]]; then
            git push
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ Pushed ${project_name}${NC}"
            else
                echo -e "${RED}✗ Failed to push ${project_name}${NC}"
            fi
        fi
    else
        echo -e "${RED}✗ Failed to commit ${project_name}${NC}"
    fi

    echo ""
}

# Főkönyvtár meghatározása
MAIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$MAIN_DIR")"
BACKEND_DIR="$WORKSPACE_DIR/backend"
FRONTEND_DIR="$WORKSPACE_DIR/frontend"

echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Backend & Frontend Commit Script       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"
echo ""

# Backend csomagok
echo -e "${BLUE}═══ BACKEND PACKAGES ══════════════════════${NC}"
echo ""

BACKEND_PACKAGES=(
    "admin"
    "cms"
    "language"
    "media"
    "menu"
    "user"
)

for package in "${BACKEND_PACKAGES[@]}"; do
    commit_project "$BACKEND_DIR/packages/$package" "Backend Package: $package"
done

# Backend fő projekt
echo -e "${BLUE}═══ BACKEND MAIN PROJECT ══════════════════${NC}"
echo ""
commit_project "$BACKEND_DIR" "Backend"

# Frontend csomagok
echo -e "${BLUE}═══ FRONTEND PACKAGES ═════════════════════${NC}"
echo ""

FRONTEND_PACKAGES=(
    "vue-admin"
    "vue-cms"
    "vue-language"
    "vue-media"
    "vue-menu"
    "vue-user"
)

for package in "${FRONTEND_PACKAGES[@]}"; do
    commit_project "$FRONTEND_DIR/src/packages/$package" "Frontend Package: $package"
done

# Frontend fő projekt
echo -e "${BLUE}═══ FRONTEND MAIN PROJECT ═════════════════${NC}"
echo ""
commit_project "$FRONTEND_DIR" "Frontend"

# Befejezés
echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   All commits completed!                  ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"

# Vissza a kiindulási könyvtárba
cd "$MAIN_DIR"

