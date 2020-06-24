default['dotfiles']['account'] = (`whoami`).strip
user = (`whoami`).strip
default['dotfiles']['homeuser'] = "/Users/#{user}"
default['dotfiles']['plugins'] = 'git brew history kubectl history-substring-search'
