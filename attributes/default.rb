default['dotfiles']['account'] = (`whoami`).strip
user = (`whoami`).strip
default['dotfiles']['homeuser'] = "/Users/#{user}"
default['dotfiles']['plugins'] = 'git brew history kubectl history-substring-search'
default['dotfiles']['plugin'] = %w(aws.plugin.zsh django.plugin.zsh vagrant-prompt.plugin.zsh virtualenv.plugin.zsh ansible.plugin.zsh).each
default['dotfiles']['libs'] = %w(git.zsh theme-and-appearance.zsh).each
