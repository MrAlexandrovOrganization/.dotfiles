FILES = .zshrc .p10k.zsh
HOME_MAKEFILES = Makefile

CONFIG_DIR = $(HOME)/.dotfiles

.PHONY: install
install:
	@git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf | true
	@~/.fzf/install --all
	@sudo apt install zsh

.PHONY: links
links:
	@for file in $(FILES); do \
		if [ -f "$(CONFIG_DIR)/$$file" ]; then \
			ln -sf "$(CONFIG_DIR)/$$file" "$(HOME)/$$file" && \
			echo "Created link: $(HOME)/$$file -> $(CONFIG_DIR)/$$file"; \
		else \
			echo "Warning: File $$file not found in $(CONFIG_DIR)"; \
		fi \
	done

	@for file in $(HOME_MAKEFILES); do \
		if [ -f "$(CONFIG_DIR)/$$file.home" ]; then \
			ln -sf "$(CONFIG_DIR)/$$file.home" "$(HOME)/$$file" && \
			echo "Created link: $(HOME)/$$file -> $(CONFIG_DIR)/$$file.home"; \
		else \
			echo "Warning: File $$file.home not found in $(CONFIG_DIR)"; \
		fi \
	done

.PHONY: clean-links
clean-links:
	@for file in $(FILES) $(HOME_MAKEFILES); do \
		if [ -L "$(HOME)/$$file" ]; then \
			rm "$(HOME)/$$file" && \
			echo "Removed link: $(HOME)/$$file"; \
		fi \
	done
