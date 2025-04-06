### Examples

```shell
echo "📦 Initializing and updating submodules..."
git submodule update --init --recursive

echo "🔄 Pulling latest commits for all submodules..."
# for bash
git submodule foreach git pull origin main
# for powershell
git submodule foreach --recursive 'git pull origin main'

echo "✅ Updating submodule references in main repo..."
git add .
git commit -m "Update submodules to latest commits"

# 모든 submodule의 현재 브랜치
git submodule foreach 'echo $name && git branch --show-current'

# 모든 submodule의 변경사항 확인
git submodule foreach 'echo $name && git status'
```

### 특정 브랜치로 추적하기

- .gitmodules가 다음과 같을 때,

```bash
[submodule "libs/libX"]
    path = libs/libX
    url = https://github.com/example/libX.git
    branch = main

# 모든 submodule을 해당 브랜치의 최신 커밋으로 업데이트해줘.
$ git submodule update --remote --merge
```

- 자주 바뀌는 모듈은 추적
- 핵심 라이브러리는 고정