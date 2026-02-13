# Main Project

Ez a főprojekt a backend és frontend projektek kezelését segíti.

## Használat

### Projekt telepítése

```bash
# Mindkét projekt klónozása
make clone

# Mindkét projekt függőségeinek telepítése
make install
```

### Projektek indítása/leállítása

```bash
# Backend és Frontend indítása
make start

# Backend leállítása
make stop
```

### Git műveletek

#### Commit script használata

A `commit.sh` script segítségével végig tudod menni a backend és frontend projekteken, valamint az összes csomagjukon, és egyesével commitolni őket.

```bash
# Script futtatása közvetlenül
./commit.sh

# VAGY Makefile-on keresztül
make commit
```

A script:
1. **Backend csomagok** - végigmegy az összes backend csomagon (admin, cms, language, media, menu, user)
2. **Backend fő projekt** - commitolja a backend fő projektet
3. **Frontend csomagok** - végigmegy az összes frontend csomagon (vue-admin, vue-cms, vue-language, vue-media, vue-menu, vue-user)
4. **Frontend fő projekt** - commitolja a frontend fő projektet

Minden projekt esetén:
- Ellenőrzi, hogy van-e változás
- Megmutatja a változásokat
- Bekér egy commit üzenetet (Enter-rel át lehet ugrani)
- Commitolja a változásokat
- Megkérdezi, hogy push-oljon-e

#### Funkciók

- ✓ Színes kimenet a jobb átláthatóság érdekében
- ✓ Minden projektet külön kezel
- ✓ Mutatja a változásokat minden projekt esetén
- ✓ Lehetőség van átugrni egy projektet
- ✓ Opcionális push minden commit után
- ✓ Hibakezelés

## Projekt struktúra

```
.
├── backend/              # Backend fő projekt
│   └── packages/         # Backend csomagok
│       ├── admin/
│       ├── cms/
│       ├── language/
│       ├── media/
│       ├── menu/
│       └── user/
├── frontend/             # Frontend fő projekt
│   └── src/packages/     # Frontend csomagok
│       ├── vue-admin/
│       ├── vue-cms/
│       ├── vue-language/
│       ├── vue-media/
│       ├── vue-menu/
│       └── vue-user/
└── main/                 # Ez a projekt
    ├── commit.sh         # Commit script
    └── Makefile          # Make parancsok
```

## Segítség

Az összes elérhető parancs megtekintéséhez:

```bash
make help
```

