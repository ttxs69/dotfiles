# setup brew
set -gx HOMEBREW_API_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
set -gx HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
set -gx HOMEBREW_CORE_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
set -gx HOMEBREW_PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"
eval "$(/opt/homebrew/bin/brew shellenv)"
# locale
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
# android
set -gx ANDROID_HOME /Users/sarace/Library/Android/sdk
# add trash-cli to path
fish_add_path /opt/homebrew/opt/trash-cli/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
end
zoxide init fish | source
set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
