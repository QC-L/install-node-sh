# !/install-node.sh
# des: 通过 shell 一键安装 node.js
# author: QC-L
# date: 2017/11/20

# 判断如果不是 macOS 并且不是 Linux，则退出
if [[ `uname` != 'Darwin' && `uname` != 'Linux' ]]; then
  exit 0
fi

# 如果是 Linux ，且没安装 git
if [[ `uname` == 'Linux'  ]]; then
  if command -v git >/dev/null 2>&1; then
    echo 'exists git'
  # 则安装
  else
    yum install git
  fi
fi

# .nvm 的路径
nvmPath="$HOME/.nvm"
# .bash_profile 的路径
bash_profilePath="$HOME/.bash_profile"
# .bashrc 的路径
bashrcPath="$HOME/.bashrc"
# 定义要安装的 node 版本
node_version="8"
# nvm 版本
nvm_version="v0.33.6"

# 判断 .bashrc 是否存在
if [[ ! -f "$bashrcPath" ]]; then
  # 不存在创建 .bashrc
  touch "$bashrcPath"
fi

# 判断 .bash_profile 是否存在
if [[ ! -f "$bash_profilePath" ]]; then
  # 不存在创建 .bash_profile
  touch "$bash_profilePath"
fi

echo "source ~/.bashrc" >> ~/.bash_profile

# 判断 .nvm 是否存在
if [[ -d "$nvmPath" ]]; then
  # 存在就移除(有可能安装失败)
  rm -rf "$nvmPath"
fi
# 官方下载 nvm
curl -o- "https://raw.githubusercontent.com/creationix/nvm/${nvm_version}/install.sh" | bash
# .bash_profile 生效
source "$bashrcPath"
source "$bash_profilePath"

# 安装 node 版本
nvm install "$node_version"
nvm use "$node_version"
nvm alias default "$node_version"

# 安装 nrm
npm install -g nrm --registry=https://registry.npm.taobao.org
# 默认使用 taobao 镜像
nrm use taobao
